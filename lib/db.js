const mysql=require('mysql2/promise');let pool;
exports.db=()=>pool||(pool=mysql.createPool({uri:process.env.DATABASE_URL,ssl:process.env.DB_SSL==='false'?undefined:{rejectUnauthorized:true},connectionLimit:3}));
