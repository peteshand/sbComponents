package storyblok.types;

import storyblok.utils.SbData;

typedef Story = {
	> Object,
	name:String,
	created_at:SbData,
	published_at:SbData,
	// Array type not confirmed
	alternates:Array<Dynamic>,
	id:Int,
	uuid:String,
	content:Dynamic,
	slug:String,
	full_slug:String,
	// Type not confirmed
	sort_by_date:Dynamic,
	position:Int,
	// Array type not confirmed
	tag_list:Array<Dynamic>,
	is_startpage:Bool,
	parent_id:Int,
	// Type not confirmed
	meta_data:Dynamic,
	group_id:String,
	first_published_at:SbData,
	// Type not confirmed
	release_id:Dynamic,
	lang:String,
	// Type not confirmed
	path:Dynamic,
}
