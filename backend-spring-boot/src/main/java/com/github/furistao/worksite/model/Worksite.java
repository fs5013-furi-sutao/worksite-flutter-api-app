package com.github.furistao.worksite.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "worksites")
public class Worksite {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Column(name = "name")
	private String name;

	@Column(name = "sub_name")
	private String subName;

	@Column(name = "type")
	private String type;

	@Column(name = "staff_name")
	private String staffName;

	@Column(name = "photo")
	private String photo;

	@Column(name = "address")
	private String address;

	@Column(name = "status")
	private String status;

	@Column(name = "start_at")
	@Temporal(TemporalType.DATE)
	private java.util.Date startAt;

	@Column(name = "end_at")
	@Temporal(TemporalType.DATE)
	private java.util.Date endAt;

	@Column(name = "created_at")
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date createdAt;

	@Column(name = "updated_at")
	@Temporal(TemporalType.TIMESTAMP)
	private java.util.Date updatedAt;
	
	public long getId() {
		return this.id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getSubName() {
		return this.subName;
	}
	public void setSubName(String subName) {
		this.subName = subName;
	}

	public String getType() {
		return this.type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getStaffName() {
		return this.staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public String getPhoto() {
		return this.photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getAddress() {
		return this.address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getStatus() {
		return this.status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public java.util.Date getStartAt() {
		return this.startAt;
	}
	public void setStartAt(java.util.Date startAt) {
		this.startAt = startAt;
	}

	public java.util.Date getEndAt() {
		return this.endAt;
	}
	public void setEndAt(java.util.Date endAt) {
		this.endAt = endAt;
	}

	public java.util.Date getCreatedAt() {
		return this.createdAt;
	}
	public void setCreatedAt(java.util.Date createdAt) {
		this.createdAt = createdAt;
	}

	public java.util.Date getUpdatedAt() {
		return this.updatedAt;
	}
	public void setUpdatedAt(java.util.Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
