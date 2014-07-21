package jp.ac.tokushima_u.is.ll.entity;

import com.google.gson.annotations.SerializedName;

public class Geometry {
	@SerializedName("location")
	private Location location;

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}
}
