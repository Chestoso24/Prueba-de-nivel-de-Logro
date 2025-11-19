<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registro de Denuncias</title>
<style>
    * {margin: 0; padding: 0; box-sizing: border-box;}
    body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px;}
    .container {background: #fff; padding: 35px 45px; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); width: 100%; max-width: 800px;}
    h2 {color: #667eea; text-align: center; margin-bottom: 30px; font-size: 28px; font-weight: 600;}
    .subtitle {text-align: center; color: #666; margin-bottom: 25px; font-size: 14px;}
    form {display: grid; grid-template-columns: 1fr 1fr; gap: 20px;}
    .form-group {display: flex; flex-direction: column;}
    .form-group.full-width {grid-column: 1 / 3;}
    label {font-weight: 600; color: #333; margin-bottom: 8px; font-size: 14px;}
    input, select, textarea {width: 100%; padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 10px; font-size: 14px; font-family: inherit; transition: all 0.3s;}
    input:focus, select:focus, textarea:focus {outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);}
    textarea {resize: vertical; min-height: 100px;}
    button {grid-column: 1 / 3; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; border: none; padding: 15px; font-size: 16px; font-weight: 600; border-radius: 10px; cursor: pointer; transition: transform 0.2s, box-shadow 0.2s; margin-top: 10px;}
    button:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);}
    button:active {transform: translateY(0);}
    .link-consulta {display: block; text-align: center; margin-top: 20px; text-decoration: none; color: #667eea; font-weight: 600; transition: color 0.3s;}
    .link-consulta:hover {color: #764ba2;}
    .required {color: #e74c3c;}
    @media (max-width: 768px) {
        form {grid-template-columns: 1fr;}
        .form-group.full-width, button {grid-column: 1;}
    }
</style>
</head>
<body>
<div class="container">
    <h2>📢 Registro de Denuncias Municipales</h2>
    <p class="subtitle">Complete el formulario para registrar una nueva denuncia ciudadana</p>
    
    <form action="grabarDenuncia.jsp" method="post">
        <div class="form-group">
            <label>Título de la Denuncia <span class="required">*</span></label>
            <input type="text" name="titulo" required maxlength="100" placeholder="Ej: Bache en Av. Principal">
        </div>
        
        <div class="form-group">
            <label>Estado <span class="required">*</span></label>
            <select name="estado" required>
                <option value="">Seleccione...</option>
                <option value="pendiente">⏳ Pendiente</option>
                <option value="en proceso">🔄 En Proceso</option>
                <option value="resuelto">✅ Resuelto</option>
            </select>
        </div>
        
        <div class="form-group full-width">
            <label>Descripción del Problema <span class="required">*</span></label>
            <textarea name="descripcion" required maxlength="255" placeholder="Describa detalladamente el problema observado..."></textarea>
        </div>
        
        <div class="form-group full-width">
            <label>Ubicación <span class="required">*</span></label>
            <input type="text" name="ubicacion" required maxlength="150" placeholder="Dirección exacta donde ocurre el problema">
        </div>
        
        <div class="form-group">
            <label>Ciudadano (Apellidos y Nombres) <span class="required">*</span></label>
            <input type="text" name="ciudadano" required maxlength="100" placeholder="Apellidos y Nombres completos">
        </div>
        
        <div class="form-group">
            <label>Teléfono de Contacto <span class="required">*</span></label>
            <input type="tel" name="telefonoCiudadano" required maxlength="15" placeholder="999999999" pattern="[0-9]{9,15}">
        </div>
        
        <button type="submit" name="accion" value="insertar">💾 Registrar Denuncia</button>
    </form>
    
    <a class="link-consulta" href="consultaDenuncias.jsp">📋 Ver todas las denuncias registradas</a>
</div>
</body>
</html>