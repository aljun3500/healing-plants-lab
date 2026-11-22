const {make,same,ok}=require('../lib/auth');
const C='; Path=/; HttpOnly; Secure; SameSite=Strict';
module.exports=async(req,res)=>{
 if(req.method==='GET')return res.status(ok(req)?200:401).json({ok:ok(req)});
 if(req.method==='DELETE'){res.setHeader('Set-Cookie','hp_session=; Max-Age=0'+C);return res.json({ok:true})}
 if(req.method!=='POST')return res.status(405).end();
 if(!process.env.ADMIN_PASSWORD||!process.env.SESSION_SECRET)return res.status(500).json({error:'Admin is not configured yet'});
 if(!same(String((req.body&&req.body.password)||''),process.env.ADMIN_PASSWORD)){await new Promise(r=>setTimeout(r,800));return res.status(401).json({error:'Wrong password'})}
 res.setHeader('Set-Cookie','hp_session='+make()+'; Max-Age=28800'+C);res.json({ok:true})};
