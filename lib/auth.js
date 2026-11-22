const c=require('crypto');
const sig=v=>c.createHmac('sha256',process.env.SESSION_SECRET||'').update(v).digest('hex');
exports.make=()=>{const e=Date.now()+8*36e5;return e+'.'+sig(String(e))};
exports.ok=req=>{if(!process.env.SESSION_SECRET)return false;const m=(req.headers.cookie||'').match(/(?:^|; )hp_session=([^;]+)/);if(!m)return false;const[e,s]=m[1].split('.');if(!e||!s||+e<Date.now())return false;const a=Buffer.from(s),b=Buffer.from(sig(e));return a.length===b.length&&c.timingSafeEqual(a,b)};
exports.same=(a,b)=>c.timingSafeEqual(c.createHash('sha256').update(a).digest(),c.createHash('sha256').update(b).digest());
