package dao;

import java.util.List;

import model.Place;

public interface PlaceDao {
	public int insertPlace(Place place);
	public int updatePlace(Place place);
	public int deletePlace(int place_index);
	public Place selectOnePlace(int place_index);
	public List<Place> selectAllPlaceByOption(Place place);
	public List<Place> selectAllPlaceByType(String placeType);
	public List<Place> selectAllPlace();
}
