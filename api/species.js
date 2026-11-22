const {db}=require('../lib/db'),{ok}=require('../lib/auth');
async function all(q){
 const [s]=await q.query('SELECT s.id,s.scientific_name sci,s.common_name common,s.toxic,s.endemic,s.family_id,s.status_id,f.family_name family,c.status_name status,s.medicinal_use `use`,s.image_url img FROM species s JOIN family f ON f.id=s.family_id JOIN conservation_status c ON c.id=s.status_id ORDER BY s.id');
 const [n]=await q.query('SELECT species_id,name n,language l FROM local_name ORDER BY id');
 const [r]=await q.query('SELECT sr.species_id sid,r.id,r.region_name nm FROM species_region sr JOIN region r ON r.id=sr.region_id ORDER BY r.id');
 return s.map(x=>({...x,toxic:+x.toxic,endemic:+x.endemic,names:n.filter(y=>y.species_id==x.id).map(({n,l})=>({n,l})),region_ids:r.filter(y=>y.sid==x.id).map(y=>y.id),regions:r.filter(y=>y.sid==x.id).map(y=>y.nm)}))}
const bad=m=>Object.assign(new Error(m),{code:400});
async function save(c,id,b){
 const sci=String(b.sci||'').trim(),common=String(b.common||'').trim(),fam=String(b.family||'').trim();
 if(!sci||!common||!fam)throw bad('Scientific name, common name and family are required');
 const [[f]]=await c.query('SELECT id FROM family WHERE family_name=?',[fam]);
 const fid=f?f.id:(await c.query('INSERT INTO family(family_name) VALUES(?)',[fam]))[0].insertId;
 const v=[sci,common,b.toxic?1:0,b.endemic?1:0,fid,+b.status_id||1,String(b.use||'').trim(),b.img?String(b.img).trim():null];
 if(id)await c.query('UPDATE species SET scientific_name=?,common_name=?,toxic=?,endemic=?,family_id=?,status_id=?,medicinal_use=?,image_url=? WHERE id=?',[...v,id]);
 else id=(await c.query('INSERT INTO species(scientific_name,common_name,toxic,endemic,family_id,status_id,medicinal_use,image_url,id) VALUES(?,?,?,?,?,?,?,?,?)',[...v,+b.id||null]))[0].insertId;
 await c.query('DELETE FROM local_name WHERE species_id=?',[id]);await c.query('DELETE FROM species_region WHERE species_id=?',[id]);
 for(const x of b.names||[])if(x.n&&x.n.trim())await c.query('INSERT INTO local_name(species_id,name,language) VALUES(?,?,?)',[id,x.n.trim(),(x.l||'Filipino').trim()]);
 for(const r of b.region_ids||[])await c.query('INSERT INTO species_region(species_id,region_id) VALUES(?,?)',[id,+r]);
 return id}
module.exports=async(req,res)=>{
 try{const p=db();
  if(req.method==='GET'){res.setHeader('Cache-Control','no-store');
   if(req.query.meta)return res.json({families:(await p.query('SELECT family_name FROM family ORDER BY family_name'))[0].map(x=>x.family_name),statuses:(await p.query('SELECT id,status_name FROM conservation_status ORDER BY id'))[0],regions:(await p.query('SELECT id,region_name FROM region ORDER BY id'))[0]});
   return res.json(await all(p))}
  if(!ok(req))return res.status(401).json({error:'Please log in again'});
  const id=+req.query.id||null;
  if(req.method==='DELETE'){if(!id)throw bad('Missing id');await p.query('DELETE FROM species WHERE id=?',[id]);return res.json({ok:true})}
  if(req.method==='POST'||req.method==='PUT'){if(req.method==='PUT'&&!id)throw bad('Missing id');
   const c=await p.getConnection();try{await c.beginTransaction();const nid=await save(c,id,req.body||{});await c.commit();return res.json({ok:true,id:nid})}catch(e){await c.rollback();throw e}finally{c.release()}}
  res.status(405).end()}
 catch(e){res.status(e.code===400?400:500).json({error:e.code===400?e.message:'Server error'})}};
