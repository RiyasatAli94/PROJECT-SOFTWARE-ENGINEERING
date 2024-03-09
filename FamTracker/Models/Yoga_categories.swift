

import Foundation
struct Yoga_categories : Codable {
	let id : Int?
	let name : String?
	let short_name : String?
	let description : String?
	let parent_yoga_category_id : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case short_name = "short_name"
		case description = "description"
		case parent_yoga_category_id = "parent_yoga_category_id"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		short_name = try values.decodeIfPresent(String.self, forKey: .short_name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		parent_yoga_category_id = try values.decodeIfPresent(String.self, forKey: .parent_yoga_category_id)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
