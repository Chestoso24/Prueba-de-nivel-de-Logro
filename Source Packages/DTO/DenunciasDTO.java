package DTO;

import DAO.DenunciasDAO;
import java.sql.Timestamp;
import java.util.Collection;

public class DenunciasDTO {
    private int id;
    private String titulo;
    private String descripcion;
    private String ubicacion;
    private String estado;
    private String ciudadano;
    private String telefonoCiudadano;
    private Timestamp fechaRegistro;

    // ======= Constructor vacío =======
    public DenunciasDTO() {
    }

    // ======= Getters y Setters =======
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCiudadano() {
        return ciudadano;
    }

    public void setCiudadano(String ciudadano) {
        this.ciudadano = ciudadano;
    }

    public String getTelefonoCiudadano() {
        return telefonoCiudadano;
    }

    public void setTelefonoCiudadano(String telefonoCiudadano) {
        this.telefonoCiudadano = telefonoCiudadano;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    // ======= Métodos CRUD =======
    public boolean insertar() {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.insert(this) > 0;
    }

    public boolean actualizar() {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.update(this) > 0;
    }

    public boolean eliminar() {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.delete(this) > 0;
    }

    public Collection<DenunciasDTO> cargarDatos() {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.buscarTodos();
    }

    public Collection<DenunciasDTO> buscarPorEstado(String estado) {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.buscarPorEstado(estado);
    }

    public Collection<DenunciasDTO> buscarPorCriterio(String criterio, String valor) {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.buscarPorCriterio(criterio, valor);
    }

    public DenunciasDTO buscarPorId(int id) {
        DenunciasDAO dao = new DenunciasDAO();
        return dao.buscarPorId(id);
    }
}