<%@page import="DAO.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Editar Denuncia</title>
<style>
    * {margin: 0; padding: 0; box-sizing: border-box;}
    body {font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px;}
    .container {background: #fff; padding: 35px 45px; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); width: 100%; max-width: 900px;}
    h2 {color: #667eea; text-align: center; margin-bottom: 30px; font-size: 28px; font-weight: 600;}
    .subtitle {text-align: center; color: #666; margin-bottom: 25px; font-size: 14px;}
    form {display: grid; grid-template-columns: 1fr 1fr; gap: 20px;}
    .form-group {display: flex; flex-direction: column;}
    .form-group.full-width {grid-column: 1 / 3;}
    label {font-weight: 600; color: #333; margin-bottom: 8px; font-size: 14px;}
    input, select, textarea {width: 100%; padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 10px; font-size: 14px; font-family: inherit; transition: all 0.3s;}
    input:focus, select:focus, textarea:focus {outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);}
    input[readonly] {background: #f3f4f6; cursor: not-allowed;}
    textarea {resize: vertical; min-height: 100px;}
    .button-group {grid-column: 1 / 3; display: flex; gap: 15px; margin-top: 10px;}
    button {flex: 1; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #fff; border: none; padding: 15px; font-size: 16px; font-weight: 600; border-radius: 10px; cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;}
    button:hover {transform: translateY(-2px); box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);}
    button:active {transform: translateY(0);}
    .btn-cancel {background: #6b7280 !important;}
    .btn-cancel:hover {box-shadow: 0 8px 20px rgba(107, 114, 128, 0.4) !important;}
    .required {color: #e74c3c;}
    .info-box {background: #eff6ff; border-left: 4px solid #3b82f6; padding: 15px; border-radius: 8px; margin-bottom: 20px; grid-column: 1 / 3;}
    .info-box strong {color: #1e40af;}
    @media (max-width: 768px) {
        form {grid-template-columns: 1fr;}
        .form-group.full-width, .button-group {grid-column: 1;}
    }
</style>
</head>
<body>
<div class="container">
    <h2>✏️ Editar Denuncia</h2>
    <p class="subtitle">Actualice la información de la denuncia seleccionada</p>
    
    <%
    String id = request.getParameter("id");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = Conexion.getConnection();
        ps = con.prepareStatement("SELECT * FROM denuncias WHERE id=?");
        ps.setString(1, id);
        rs = ps.executeQuery();
        
        if(rs.next()){
    %>
    
    <form action="grabarDenuncia.jsp" method="post">
        <input type="hidden" name="accion" value="actualizar">
        
        <div class="info-box">
            <strong>ID de Denuncia:</strong> #<%= rs.getInt("id") %> | 
            <strong>Fecha de Registro:</strong> <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(rs.getTimestamp("fecha_registro")) %>
        </div>
        
        <div class="form-group">
            <label>ID (Solo lectura)</label>
            <input type="text" name="id" value="<%= rs.getInt("id") %>" readonly>
        </div>
        
        <div class="form-group">
            <label>Estado <span class="required">*</span></label>
            <select name="estado" required>
                <option value="pendiente" <%= "pendiente".equals(rs.getString("estado")) ? "selected" : "" %>>⏳ Pendiente</option>
                <option value="en proceso" <%= "en proceso".equals(rs.getString("estado")) ? "selected" : "" %>>🔄 En Proceso</option>
                <option value="resuelto" <%= "resuelto".equals(rs.getString("estado")) ? "selected" : "" %>>✅ Resuelto</option>
            </select>
        </div>
        
        <div class="form-group full-width">
            <label>Título de la Denuncia <span class="required">*</span></label>
            <input type="text" name="titulo" value="<%= rs.getString("titulo") %>" required maxlength="100">
        </div>
        
        <div class="form-group full-width">
            <label>Descripción del Problema <span class="required">*</span></label>
            <textarea name="descripcion" required maxlength="255"><%= rs.getString("descripcion") %></textarea>
        </div>
        
        <div class="form-group full-width">
            <label>Ubicación <span class="required">*</span></label>
            <input type="text" name="ubicacion" value="<%= rs.getString("ubicacion") %>" required maxlength="150">
        </div>
        
        <div class="form-group">
            <label>Ciudadano (Apellidos y Nombres) <span class="required">*</span></label>
            <input type="text" name="ciudadano" value="<%= rs.getString("ciudadano") %>" required maxlength="100">
        </div>
        
        <div class="form-group">
            <label>Teléfono de Contacto <span class="required">*</span></label>
            <input type="tel" name="telefonoCiudadano" value="<%= rs.getString("telefono_ciudadano") %>" required maxlength="15" pattern="[0-9]{9,15}">
        </div>
        
        <div class="button-group">
            <button type="submit">💾 Actualizar Denuncia</button>
            <button type="button" class="btn-cancel" onclick="window.location.href='consultaDenuncias.jsp'">❌ Cancelar</button>
        </div>
    </form>
    
    <%
        } else {
    %>
        <div style="text-align: center; padding: 40px;">
            <h3 style="color: #ef4444;">⚠️ Denuncia no encontrada</h3>
            <p style="margin: 20px 0; color: #6b7280;">La denuncia con ID <%= id %> no existe en el sistema.</p>
            <a href="consultaDenuncias.jsp" style="display: inline-block; background: #667eea; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: 600;">← Volver a la lista</a>
        </div>
    <%
        }
    } catch(Exception e) {
    %>
        <div style="text-align: center; padding: 40px;">
            <h3 style="color: #ef4444;">⚠️ Error al cargar la denuncia</h3>
            <p style="margin: 20px 0; color: #6b7280;"><%= e.getMessage() %></p>
            <a href="consultaDenuncias.jsp" style="display: inline-block; background: #667eea; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: 600;">← Volver a la lista</a>
        </div>
    <%
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception e) {}
        if (ps != null) try { ps.close(); } catch(Exception e) {}
        if (con != null) try { con.close(); } catch(Exception e) {}
    }
    %>
</div>
</body>
</html>