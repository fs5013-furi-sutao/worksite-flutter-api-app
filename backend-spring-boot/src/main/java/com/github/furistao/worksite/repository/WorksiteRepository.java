package com.github.furistao.worksite.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

import com.github.furistao.worksite.model.Worksite;

@Repository
public interface WorksiteRepository extends JpaRepository<Worksite, Long> {

        @Query(value = "SELECT w.id, w.name, w.sub_name, w.type, w.staff_name, w.photo, w.address, w.status, w.start_at, w.end_at, w.created_at, s.updated_at FROM worksites w ORDER BY w.id DESC LIMIT 1", nativeQuery = true)
        Worksite getMaxIdworksite();

        @Query(value = "SELECT w.id, w.name, w.sub_name, w.type, w.staff_name, w.photo, w.address, w.status, w.start_at, w.end_at, w.created_at, s.updated_at FROM worksites w WHERE w.start_at BETWEEN :from AND :to ORDER BY w.start_at ASC", nativeQuery = true)
        List<Worksite> findByStartAtBetween(@Param("from") String from, @Param("to") String to);
}
