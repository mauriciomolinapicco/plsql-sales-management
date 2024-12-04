db.socios.insertOne({
    nombre:'abcd', correo:'ejemplo@gmail.com', edad:21, categoria: 'Invitado', contrasenia:1234, 
    reservas: [
        {
            cantidad_horas:1,
            fecha:'01/01/2024',
            hora:'17:00',
            cancha: {
                numero:1, 
                deportes:['futbol', 'rugby'], 
                costo_hora:10000
            }

        }
    ]
});


db.canchas.insertOne({
    numero:1, deportes:['futbol', 'rugby'], costo_hora:10000,
    reservas: [
        {
            usuario: {nombre: 'abcd', correo:'ejemplo@gmail.com'},
            cantidad_horas:1,
            fecha:'01/01/2024',
            hora:'17:00'
        }
    ],
    propietario: {
        nombre:'juan gomez',
        
    }
    
})