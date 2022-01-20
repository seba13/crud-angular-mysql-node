

const rutas = require('express').Router();
const { Router } = require('express');
const { route } = require('express/lib/application');
const conexion = require('./config/conexion');
// console.log("rutas: "+rutas)

//asignar todas las rutas
// rutas.get('/', (req, res) => {

//         //     ¿Qué es la respuesta HTTP?
//         // La respuesta o HTTP response es el mensaje que envía el servidor al cliente tras haber recibido una petición o HTTP request
//         // envia una respuesta http
//         res.send('<h1>Hola mundo!</h1>')
        
// })


// --------------------------------------------------------

// rutas y peticiones de cliente
// es necesario realizar la conexion a mysql (linea 4)

//mostrar productos
rutas.get('/', (req, res)=>{

        let sql = "call sp_mostrar_productos_detalle();"
        conexion.query(sql,(err, rows, fields)=>{
                if(err) throw err;
                else{
                        res.json(rows[0])
                }
        })

})

//mostrar marcas
rutas.get('/marcas', (req, res)=>{

        let sql = "call sp_mostrar_marcas_detalle()";
        conexion.query(sql, (err, rows, fields)=>{
                if(err) throw err;
                else{
                        res.json(rows[0])
                }
        })
});



rutas.get('/marcas/producto/:id', (req, res)=>{
        let {id} = req.params;
        let sql = `select * from productos where productos.id_marca='${id}';`
        conexion.query(sql, (err, rows, fields)=>{
                if(err) throw err;
                else{

                        res.json(rows);
                        
                }
        })
})



// obtener un producto
rutas.get('/:id',(req, res)=>{
        const {id} = req.params
        let sql = "select * from productos where productos.id_producto = ?;"
        conexion.query(sql,[id],(err,rows,fields)=>{
        
                if(err) throw err;
                else{
                        res.json(rows[0])
                }
        });
})

//obtener producto por nombre
rutas.get('/producto/:nombre', (req, res)=>{
        const {nombre} = req.params
        let sql = `select * from productos where productos.nombre_producto='${nombre}';`
        conexion.query(sql, (err, rows, fields)=>{
                if(err) throw err;
                else{
                        res.json(rows[0])
                }
        })
})


// obtener marca por nombre
rutas.get('/marcas/marca/:nombre', (req, res)=>{
        const {nombre} = req.params
        let sql = `select * from marcas where marcas.nombre_marca='${nombre}';`
        conexion.query(sql,[nombre], (err, rows, fields)=>{
                if(err) throw err;
                else{
                        res.json(rows[0])
                }
        })
})



//obtener una marca
rutas.get('/marcas/:id', (req,res)=>{
        const {id} = req.params
        let sql = 'select * from marcas where marcas.id_marca=?;';
        conexion.query(sql,[id],(err,rows,fields)=>{
                if(err) throw err;
                else{
                        res.json(rows[0]);
                }
        })
})




// agregar producto
rutas.post('/',(req,res)=>{
        const{nombre_producto, valor, estado, id_marca} = req.body;

        let sql = `call sp_agregar_producto('${nombre_producto}','${valor}','${estado}','${id_marca}');` 
        conexion.query(sql, (error, rows, fields) =>{
                if(error) throw error
                else{
                        res.json({status:'Producto agregado'});
                }
        })

})

//agregar marca
rutas.post('/marcas/', (req, res)=>{

        const{nombre_marca,estado} = req.body;
        let sql = `call sp_agregar_marca('${nombre_marca}','${estado}');`
        conexion.query(sql, (err, rows, fields)=>{
                if(err) throw err;
                else{
                        res.json({status: 'Marca agregada'})
                }
        })
})


//eliminar producto
rutas.delete('/:id', (req, res)=>{
        const {id}= req.params
        let sql = `call sp_eliminar_producto('${id}')`;
        conexion.query(sql, (err, row, fields)=>{
                if(err) throw err;
                else{
                        res.json({status: "producto eliminado"});
                }
        })
});


//eliminar marca
rutas.delete('/marcas/:id', (req, res)=>{
        const {id} = req.params
        let sql = `call sp_eliminar_marca('${id}');`
        conexion.query(sql, (err, row, fields)=>{
                if(err) throw err;
                else{
                        res.json({status: "marca eliminada"})
                }
        })
})



//actualizar producto
rutas.put('/:id', (req, res)=>{

       const {id} = req.params;
       const {nombre_producto, valor, estado, id_marca} = req.body;

       let sql = `call sp_actualizar_producto('${id}','${nombre_producto}','${valor}','${estado}','${id_marca}');`

       conexion.query(sql, (err, row, fields)=>{
               if(err) throw err;
               else{
                       res.json({status: "producto actualizado"});
               }
       })
})


//actualizar marca
rutas.put('/marcas/:id', (req, res)=>{

        const {id} = req.params;
        const {nombre_marca, estado} = req.body;
        let sql = `call sp_actualizar_marca('${id}','${nombre_marca}','${estado}');`
        conexion.query(sql, (err, row, fields)=>{
                if(err) throw err;
                else{
                        res.json({status: "marca actualizada"});
                }
        })

})



module.exports = rutas;