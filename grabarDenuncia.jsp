<%@page import="DTO.DenunciasDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Procesando Denuncia</title>
<style>
body {font-family: 'Segoe UI', Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px;}
.message-box {background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); text-align: center; max-width: 500px;}
.success {color: #10b981;}
.error {color: #ef4444;}
.icon {font-size: 64px; margin-bottom: 20px;}
h2 {margin: 20px 0; font-size: 24px;}
p {color: #6b7280; margin: 15px 0; font-size: 16px;}
.btn {display: inline-block; background: #667eea; color: white; padding: 12px 30px; border-radius: 10px; text-decoration: none; margin-top: 20px; font-weight: 600; transition: all 0.3s;}
.btn:hover {background: #5568d3; transform: translateY(-2px);}
</style>
</head>
<body>
<div class="message-box">
<%
try {
    String accion = request.getParameter("accion");
    DenunciasDTO dto = new DenunciasDTO();
    boolean resultado = false;
    String mensaje = "";
    String icono = "";
    
    if ("insertar".equals(accion)) {
        // Insertar nueva denuncia
        dto.setTitulo(request.getParameter("titulo"));
        dto.setDescripcion(request.getParameter("descripcion"));
        dto.setUbicacion(request.getParameter("ubicacion"));
        dto.setEstado(request.getParameter("estado"));
        dto.setCiudadano(request.getParameter("ciudadano"));
        dto.setTelefonoCiudadano(request.getParameter("telefonoCiudadano"));
        
        resultado = dto.insertar();
        mensaje = resultado ? "Denuncia registrada exitosamente" : "No se pudo registrar la denuncia";
        icono = resultado ? "✅" : "❌";
        
    } else if ("actualizar".equals(accion)) {
        // Actualizar denuncia existente
        dto.setId(Integer.parseInt(request.getParameter("id")));
        dto.setTitulo(request.getParameter("titulo"));
        dto.setDescripcion(request.getParameter("descripcion"));
        dto.setUbicacion(request.getParameter("ubicacion"));
        dto.setEstado(request.getParameter("estado"));
        dto.setCiudadano(request.getParameter("ciudadano"));
        dto.setTelefonoCiudadano(request.getParameter("telefonoCiudadano"));
        
        resultado = dto.actualizar();
        mensaje = resultado ? "Denuncia actualizada correctamente" : "No se pudo actualizar la denuncia";
        icono = resultado ? "✅" : "❌";
        
    } else if ("eliminar".equals(accion)) {
        // Eliminar denuncia
        dto.setId(Integer.parseInt(request.getParameter("id")));
        resultado = dto.eliminar();
        mensaje = resultado ? "Denuncia eliminada exitosamente" : "No se pudo eliminar la denuncia";
        icono = resultado ? "🗑️" : "❌";
    }
    
    if (resultado) {
%>
    <div class="icon success"><%= icono %></div>
    <h2 class="success">¡Operación Exitosa!</h2>
    <p><%= mensaje %></p>
    <a href="consultaDenuncias.jsp" class="btn">📋 Ver todas las denuncias</a>
    <% if ("insertar".equals(accion)) { %>
        <a href="indexDenuncia.jsp" class="btn" style="background: #10b981; margin-left: 10px;">➕ Registrar otra</a>
    <% } %>
<%
    } else {
%>
    <div class="icon error">❌</div>
    <h2 class="error">Error en la Operación</h2>
    <p><%= mensaje %></p>
    <p style="font-size: 14px; color: #ef4444;">Por favor, verifique los datos e intente nuevamente.</p>
    <a href="javascript:history.back()" class="btn" style="background: #6b7280;">← Volver</a>
    <a href="consultaDenuncias.jsp" class="btn">📋 Ir a la lista</a>
<%
    }
} catch (Exception e) {
%>
    <div class="icon error">⚠️</div>
    <h2 class="error">Error del Sistema</h2>
    <p>Ha ocurrido un error inesperado:</p>
    <p style="font-size: 14px; color: #ef4444; background: #fee; padding: 15px; border-radius: 8px; margin: 15px 0; word-break: break-word;">
        <%= e.getMessage() %>
    </p>
    <a href="javascript:history.back()" class="btn" style="background: #6b7280;">← Volver</a>
    <a href="consultaDenuncias.jsp" class="btn">📋 Ir a la lista</a>
<%
}
%>
</div>
</body>
</html>
