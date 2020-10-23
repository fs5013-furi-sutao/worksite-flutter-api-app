package com.github.furistao.worksite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.github.furistao.worksite.exception.ResourceNotFoundException;
import com.github.furistao.worksite.model.Worksite;
import com.github.furistao.worksite.repository.WorksiteRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
// import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.annotations.Api;

// @CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/v1/")
@Api(tags = "現場管理情報")
public class WorksiteController {

	@Autowired
	private WorksiteRepository worksiteRepository;

	// get all worksites
	@GetMapping("/worksites")
	public List<Worksite> getAllCase() {
		return worksiteRepository.findAll();
	}

	// get max id of worksites
	@GetMapping("/worksites/maxid")
	public Worksite getMaxIdCase() {
		return worksiteRepository.getMaxIdworksite();
	}

	// create worksite rest api
	@PostMapping("/worksites")
	public Worksite createCase(@RequestBody Worksite worksite) {
		worksite.setCreatedAt(new java.util.Date());
		worksite.setUpdatedAt(new java.util.Date());
		return worksiteRepository.save(worksite);
	}

	// get worksite by id rest api
	@GetMapping("/worksites/{id}")
	public ResponseEntity<Worksite> getWorksiteById(@PathVariable Long id) {
		Worksite aCase = worksiteRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Worksite not exist with id :" + id));
		return ResponseEntity.ok(aCase);
	}

	// update worksite rest api
	@PutMapping("/worksites/{id}")
	public ResponseEntity<Worksite> updateCase(@PathVariable Long id, @RequestBody Worksite updatedData) {

		worksiteRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Worksite for updating not exist with id :" + id));

		updatedData.setUpdatedAt(new java.util.Date());
		Worksite updatedCase = worksiteRepository.save(updatedData);
		return ResponseEntity.ok(updatedCase);
	}

	// delete worksite rest api
	@DeleteMapping("/worksites/{id}")
	public ResponseEntity<Map<String, Boolean>> deleteCase(@PathVariable Long id) {
		Worksite aCase = worksiteRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Worksite not exist with id :" + id));

		worksiteRepository.delete(aCase);
		Map<String, Boolean> response = new HashMap<>();
		response.put("deleted", Boolean.TRUE);
		return ResponseEntity.ok(response);
	}

	// get temperatures during the days
	@GetMapping("/case/updated/from/{strFrom}/to/{srtTo}")
	// http://localhost:8080/api/v1/temperatures/date/from/2020-09-03/to/2020-09-30
	public List<Worksite> getCaseByUpdatedBetween(@PathVariable String strFrom, @PathVariable String srtTo) {

		return worksiteRepository.findByStartAtBetween(strFrom, srtTo);
	}
}
