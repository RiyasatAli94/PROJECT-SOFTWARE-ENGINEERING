

import Foundation
struct Items : Codable {
	let id : Int?
	let sanskrit_name : String?
	let english_name : String?
	let img_url : String?
	let created_at : String?
	let updated_at : String?
	let yoga_categories : [Yoga_categories]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case sanskrit_name = "sanskrit_name"
		case english_name = "english_name"
		case img_url = "img_url"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case yoga_categories = "yoga_categories"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		sanskrit_name = try values.decodeIfPresent(String.self, forKey: .sanskrit_name)
		english_name = try values.decodeIfPresent(String.self, forKey: .english_name)
		img_url = try values.decodeIfPresent(String.self, forKey: .img_url)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		yoga_categories = try values.decodeIfPresent([Yoga_categories].self, forKey: .yoga_categories)
	}

}
