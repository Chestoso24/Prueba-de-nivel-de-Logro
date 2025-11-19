<%@page import="DTO.DenunciasDTO"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Consulta de Denuncias</title>
<style>
* {margin: 0; padding: 0; box-sizing: border-box;}
body {font-family: 'Segoe UI', Arial, sans-serif; background: #f5f7fa; padding: 20px;}
.header {background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);}
h2 {font-size: 32px; margin-bottom: 10px;}
.subtitle {opacity: 0.9; font-size: 16px;}
.controls {background: #fff; padding: 25px; border-radius: 15px; margin-bottom: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);}
.search-section {display: grid; grid-template-columns: 200px 1fr 150px; gap: 15px; margin-bottom: 20px;}
.filter-section {display: flex; gap: 10px; flex-wrap: wrap;}
.btn-new {background: #10b981; color: #fff; padding: 12px 24px; border-radius: 10px; text-decoration: none; font-weight: 600; display: inline-block; transition: all 0.3s;}
.btn-new:hover {background: #059669; transform: translateY(-2px);}
select, input {padding: 10px 15px; border: 2px solid #e5e7eb; border-radius: 8px; font-size: 14px; width: 100%;}
select:focus, input:focus {outline: none; border-color: #667eea;}
.btn-search {background: #667eea; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; transition: all 0.3s;}
.btn-search:hover {background: #5568d3;}
.badge {display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase;}
.badge-pendiente {background: #fef3c7; color: #92400e;}
.badge-proceso {background: #dbeafe; color: #1e40af;}
.badge-resuelto {background: #d1fae5; color: #065f46;}
.table-container {background: #fff; border-radius: 15px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.08);}
table {width: 100%; border-collapse: collapse; font-size: 14px;}
th {background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 16px 12px; text-align: left; font-weight: 600; position: sticky; top: 0;}
td {padding: 14px 12px; border-bottom: 1px solid #f3f4f6;}
tr:hover {background: #f9fafb;}
.actions {display: flex; gap: 8px;}
.btn-delete {background: #ef4444; color: #fff; padding: 8px 12px; border-radius: 6px; border: none; cursor: pointer; font-size: 12px; transition: all 0.3s;}
.btn-delete:hover {background: #dc2626;}
.btn-edit {background: #3b82f6; color: #fff; padding: 8px 12px; border-radius: 6px; border: none; cursor: pointer; font-size: 12px; transition: all 0.3s;}
.btn-edit:hover {background: #2563eb;}
.no-data {text-align: center; padding: 40px; color: #6b7280;}
.stats {display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 25px;}
.stat-card {background: white; padding: 20px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); text-align: center;}
.stat-number {font-size: 32px; font-weight: 700; color: #667eea; margin-bottom: 5px;}
.stat-label {color: #6b7280; font-size: 14px; text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px;}
@media (max-width: 768px) {
    .search-section {grid-template-columns: 1fr; gap: 10px;}
    .table-container {overflow-x: auto;}
}
</style>
</head>
<body>
<div class="header">
    <h2>📋 Sistema de Denuncias Municipales</h2>
    <p class="subtitle">Gestión y seguimiento de denuncias ciudadanas</p>
</div>

<%
DenunciasDTO dto = new DenunciasDTO();
Collection<DenunciasDTO> lista = null;

// Obtener parámetros de búsqueda
String criterio = request.getParameter("criterio");
String busqueda = request.getParameter("busqueda");
String filtroEstado = request.getParameter("filtroEstado");

// Lógica de búsqueda
if (busqueda != null && !busqueda.trim().isEmpty() && criterio != null) {
    lista = dto.buscarPorCriterio(criterio, busqueda.trim());
} else if (filtroEstado != null && !filtroEstado.isEmpty()) {
    lista = dto.buscarPorEstado(filtroEstado);
} else {
    lista = dto.cargarDatos();
}

// Calcular estadísticas
int totalPendientes = 0, totalEnProceso = 0, totalResueltas = 0;
for (DenunciasDTO d : lista) {
    if ("pendiente".equals(d.getEstado())) totalPendientes++;
    else if ("en proceso".equals(d.getEstado())) totalEnProceso++;
    else if ("resuelto".equals(d.getEstado())) totalResueltas++;
}
%>

<div class="stats">
    <div class="stat-card">
        <div class="stat-number"><%= lista.size() %></div>
        <div class="stat-label">Total Denuncias</div>
    </div>
    <div class="stat-card">
        <div class="stat-number" style="color: #f59e0b;"><%= totalPendientes %></div>
        <div class="stat-label">Pendientes</div>
    </div>
    <div class="stat-card">
        <div class="stat-number" style="color: #3b82f6;"><%= totalEnProceso %></div>
        <div class="stat-label">En Proceso</div>
    </div>
    <div class="stat-card">
        <div class="stat-number" style="color: #10b981;"><%= totalResueltas %></div>
        <div class="stat-label">Resueltas</div>
    </div>
</div>

<div class="controls">
    <form method="get" action="consultaDenuncias.jsp">
        <div class="search-section">
            <select name="criterio">
                <option value="titulo" <%= "titulo".equals(criterio) ? "selected" : "" %>>Título</option>
                <option value="ciudadano" <%= "ciudadano".equals(criterio) ? "selected" : "" %>>Ciudadano</option>
                <option value="ubicacion" <%= "ubicacion".equals(criterio) ? "selected" : "" %>>Ubicación</option>
            </select>
            <input type="text" name="busqueda" placeholder="Buscar..." value="<%= busqueda != null ? busqueda : "" %>">
            <button type="submit" class="btn-search">🔍 Buscar</button>
        </div>
    </form>
    
    <div class="filter-section">
        <a href="consultaDenuncias.jsp" class="btn-search" style="text-decoration: none; display: inline-block;">🔄 Todas</a>
        <a href="consultaDenuncias.jsp?filtroEstado=pendiente" class="btn-search" style="background: #f59e0b; text-decoration: none; display: inline-block;">⏳ Pendientes</a>
        <a href="consultaDenuncias.jsp?filtroEstado=en proceso" class="btn-search" style="background: #3b82f6; text-decoration: none; display: inline-block;">🔄 En Proceso</a>
        <a href="consultaDenuncias.jsp?filtroEstado=resuelto" class="btn-search" style="background: #10b981; text-decoration: none; display: inline-block;">✅ Resueltas</a>
        <a href="indexDenuncia.jsp" class="btn-new">➕ Nueva Denuncia</a>
    </div>
</div>

<div class="table-container">
    <% if (lista.isEmpty()) { %>
        <div class="no-data">
            <h3>📭 No se encontraron denuncias</h3>
            <p>No hay denuncias registradas con los criterios seleccionados</p>
        </div>
    <% } else { %>
    <table>
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Descripción</th>
            <th>Ubicación</th>
            <th>Estado</th>
            <th>Ciudadano</th>
            <th>Teléfono</th>
            <th>Fecha Registro</th>
            <th>Acciones</th>
        </tr>
        <%
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        for (DenunciasDTO d : lista) {
            String badgeClass = "badge-pendiente";
            if ("en proceso".equals(d.getEstado())) badgeClass = "badge-proceso";
            else if ("resuelto".equals(d.getEstado())) badgeClass = "badge-resuelto";
        %>
        <tr>
            <td><strong>#<%= d.getId() %></strong></td>
            <td><%= d.getTitulo() %></td>
            <td><%= d.getDescripcion().length() > 50 ? d.getDescripcion().substring(0, 50) + "..." : d.getDescripcion() %></td>
            <td><%= d.getUbicacion() %></td>
            <td><span class="badge <%= badgeClass %>"><%= d.getEstado() %></span></td>
            <td><%= d.getCiudadano() %></td>
            <td><%= d.getTelefonoCiudadano() %></td>
            <td><%= sdf.format(d.getFechaRegistro()) %></td>
            <td>
                <div class="actions">
                    <form action="grabarDenuncia.jsp" method="post" onsubmit="return confirm('¿Está seguro de eliminar la denuncia #<%= d.getId() %>?');" style="margin: 0;">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" class="btn-delete">🗑️</button>
                    </form>
                    <form action="editarDenuncia.jsp" method="get" style="margin: 0;">
                        <input type="hidden" name="id" value="<%= d.getId() %>">
                        <button type="submit" class="btn-edit">✏️</button>
                    </form>
                </div>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>
</body>
</html>