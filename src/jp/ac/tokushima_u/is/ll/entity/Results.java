package jp.ac.tokushima_u.is.ll.entity;

import java.util.List;

import com.google.gson.annotations.SerializedName;

public class Results {
	@SerializedName("geometry")
	private Geometry geometry;

	@SerializedName("icon")
	private String icon;

	@SerializedName("id")
	private String id;

	@SerializedName("name")
	private String name;

	@SerializedName("photos")
	private List<Photos> photos;

	@SerializedName("rating")
	private Double rating;

	@SerializedName("reference")
	private String reference;

	@SerializedName("types")
	private List<String> types;

	@SerializedName("vicinity")
	private String vicinity;

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public List<String> getTypes() {
		return types;
	}

	public void setTypes(List<String> types) {
		this.types = types;
	}

	public String getVicinity() {
		return vicinity;
	}

	public void setVicinity(String vicinity) {
		this.vicinity = vicinity;
	}

	public Geometry getGeometry() {
		return geometry;
	}

	public void setGeometry(Geometry geometry) {
		this.geometry = geometry;
	}

	public List<Photos> getPhotos() {
		return photos;
	}

	public void setPhotos(List<Photos> photos) {
		this.photos = photos;
	}
}
