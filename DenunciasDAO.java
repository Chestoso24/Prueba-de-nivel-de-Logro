package DAO;

import DTO.DenunciasDTO;
import java.sql.*;
import java.util.Collection;
import java.util.Vector;

public class DenunciasDAO {

    // ======= INSERT =======
    public int insert(DenunciasDTO dto) {
        String sql = "INSERT INTO denuncias (titulo, descripcion, ubicacion, estado, ciudadano, telefono_ciudadano) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, dto.getTitulo());
            ps.setString(2, dto.getDescripcion());
            ps.setString(3, dto.getUbicacion());
            ps.setString(4, dto.getEstado());
            ps.setString(5, dto.getCiudadano());
            ps.setString(6, dto.getTelefonoCiudadano());

            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al insertar denuncia: " + e.getMessage());
        }
    }

    // ======= SELECT (todos) =======
    public Collection<DenunciasDTO> buscarTodos() {
        String sql = "SELECT * FROM denuncias ORDER BY fecha_registro DESC";
        Vector<DenunciasDTO> lista = new Vector<>();

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearDenuncia(rs));
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException("Error al listar denuncias: " + e.getMessage());
        }
    }

    // ======= SELECT por ID =======
    public DenunciasDTO buscarPorId(int id) {
        String sql = "SELECT * FROM denuncias WHERE id = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearDenuncia(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar denuncia por ID: " + e.getMessage());
        }
        return null;
    }

    // ======= SELECT por Estado =======
    public Collection<DenunciasDTO> buscarPorEstado(String estado) {
        String sql = "SELECT * FROM denuncias WHERE estado = ? ORDER BY fecha_registro DESC";
        Vector<DenunciasDTO> lista = new Vector<>();

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearDenuncia(rs));
                }
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por estado: " + e.getMessage());
        }
    }

    // ======= BÚSQUEDA por Criterio (título, ciudadano, ubicación) =======
    public Collection<DenunciasDTO> buscarPorCriterio(String criterio, String valor) {
        String sql = "SELECT * FROM denuncias WHERE " + criterio + " LIKE ? ORDER BY fecha_registro DESC";
        Vector<DenunciasDTO> lista = new Vector<>();

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + valor + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearDenuncia(rs));
                }
            }
            return lista;
        } catch (SQLException e) {
            throw new RuntimeException("Error al buscar por criterio: " + e.getMessage());
        }
    }

    // ======= UPDATE =======
    public int update(DenunciasDTO dto) {
        String sql = "UPDATE denuncias SET titulo=?, descripcion=?, ubicacion=?, estado=?, ciudadano=?, telefono_ciudadano=? WHERE id=?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, dto.getTitulo());
            ps.setString(2, dto.getDescripcion());
            ps.setString(3, dto.getUbicacion());
            ps.setString(4, dto.getEstado());
            ps.setString(5, dto.getCiudadano());
            ps.setString(6, dto.getTelefonoCiudadano());
            ps.setInt(7, dto.getId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al actualizar denuncia: " + e.getMessage());
        }
    }

    // ======= DELETE =======
    public int delete(DenunciasDTO dto) {
        String sql = "DELETE FROM denuncias WHERE id=?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, dto.getId());
            return ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error al eliminar denuncia: " + e.getMessage());
        }
    }

    // ======= Método auxiliar para mapear ResultSet a DTO =======
    private DenunciasDTO mapearDenuncia(ResultSet rs) throws SQLException {
        DenunciasDTO dto = new DenunciasDTO();
        dto.setId(rs.getInt("id"));
        dto.setTitulo(rs.getString("titulo"));
        dto.setDescripcion(rs.getString("descripcion"));
        dto.setUbicacion(rs.getString("ubicacion"));
        dto.setEstado(rs.getString("estado"));
        dto.setCiudadano(rs.getString("ciudadano"));
        dto.setTelefonoCiudadano(rs.getString("telefono_ciudadano"));
        dto.setFechaRegistro(rs.getTimestamp("fecha_registro"));
        return dto;
    }
}