package com.uploaddownloadfilesexample.domain;

import com.uploaddownloadfilesexample.domain.Attachment;
import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Attachment_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Attachment.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Attachment.id;
    
    @Version
    @Column(name = "version")
    private Integer Attachment.version;
    
    public Long Attachment.getId() {
        return this.id;
    }
    
    public void Attachment.setId(Long id) {
        this.id = id;
    }
    
    public Integer Attachment.getVersion() {
        return this.version;
    }
    
    public void Attachment.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Attachment.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Attachment.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Attachment attached = this.entityManager.find(Attachment.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Attachment.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Attachment.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Attachment merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Attachment.entityManager() {
        EntityManager em = new Attachment().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Attachment.countAttachments() {
        return (Long) entityManager().createQuery("select count(o) from Attachment o").getSingleResult();
    }
    
    public static List<Attachment> Attachment.findAllAttachments() {
        return entityManager().createQuery("select o from Attachment o").getResultList();
    }
    
    public static Attachment Attachment.findAttachment(Long id) {
        if (id == null) return null;
        return entityManager().find(Attachment.class, id);
    }
    
    public static List<Attachment> Attachment.findAttachmentEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Attachment o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
