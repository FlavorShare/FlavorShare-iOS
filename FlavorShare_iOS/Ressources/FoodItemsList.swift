//
//  FoodItemsList.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-06.
//

import Foundation

class FoodItemsList {
    static let shared = FoodItemsList()
    
    private let decoder = JSONDecoder()
    var foodItems: [FoodItem] = []
    
    private init() {
        loadFoodItems()
    }
    
    func loadFoodItems() {
        let FOOD_ITEMS_JSON = """
                [{
                  "_id": "3E5B6C09-3054-41E2-BFA5-4B80C52BEE4E",
                  "name": "Abiu (Pouteria Caimito)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0AAE6F8D-8A3A-4E6A-960D-9C39E08765B0",
                  "name": "Açaí",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "516A797E-96E7-4F1E-BEFF-1C99AB456502",
                  "name": "Acerola",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0670CB67-0567-45EB-B3D3-0FC685B7AA24",
                  "name": "Akebi (Chocolate Vine)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "417F3876-C561-4030-992E-EAF97B1E12D8",
                  "name": "Ackee",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "72BA0665-F3CA-4DB1-9D52-C6EA53D68109",
                  "name": "African Cherry Orange",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6E9492F1-A973-4C8C-9032-58F4D6AD0117",
                  "name": "American Mayapple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B319920B-B8A9-438D-AA49-87578EA52760",
                  "name": "Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F44F8DA1-3216-4E70-8710-0974776CA23B",
                  "name": "Apricot",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "46C75AC4-7905-48F3-B8BF-5BC391D9C326",
                  "name": "Aratiles",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A84B6200-C39C-4A51-B55F-B893CF09D7A9",
                  "name": "Araza",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FCABA1D6-040C-41A2-A04C-3E26DB2D79A9",
                  "name": "Avocado",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2690E706-547F-4F1A-A5CE-A34885CD2C81",
                  "name": "Banana",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8FD2C055-906C-43EF-8920-6B1099C1ED4D",
                  "name": "Bilberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "87E0FD76-FDF3-439C-A42D-236F47294615",
                  "name": "Blackberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5DA6AF7B-BB73-43A5-8410-35C0EEC54CCB",
                  "name": "Blackcurrant",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "351F54FE-D5A2-409C-93B5-F5C81E189DF5",
                  "name": "Black Sapote",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7345B068-0BE6-4ED4-A75B-2749E0F6CD9D",
                  "name": "Blueberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2D2C7541-450E-433A-9D34-2A856B049BA6",
                  "name": "Boysenberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1A761F7E-A3C8-46BB-8B5E-0544089E6743",
                  "name": "Breadfruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ACF1A779-840C-4C9F-B4AC-AA43766702E1",
                  "name": "Buddha's hand (fingered citron)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EF1A8D4A-4FEF-4459-B806-EE3A3E1656E4",
                  "name": "Cactus pear",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BD4132E7-C037-4AA4-A6BB-061867BFA74C",
                  "name": "Canistel (Egg fruit)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D46FC6B4-B984-4106-A5BA-2A8A7590F0E9",
                  "name": "Catmon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "40366096-5800-43E5-8770-6556BC80EDC5",
                  "name": "Cempedak",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A2D4E46E-B3F8-4DAD-8759-263503207871",
                  "name": "Cherimoya (Custard Apple)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D187C6BD-8906-4804-9AF9-1A8A4B6830CB",
                  "name": "Cherry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0349A0E6-3A98-4BDB-8BCE-83DD7FCEF351",
                  "name": "Chico fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "70AE269A-5FE4-4824-BD24-B4EDF5291D8A",
                  "name": "Citron",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DD1A8698-2877-4449-8541-CB00FDB7CB8C",
                  "name": "Cloudberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3C4ACE67-ECC7-42A6-9283-DA67CD1A04DE",
                  "name": "Coco de mer",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DABA3A51-ED0D-4341-96AC-B6D70927A4F1",
                  "name": "Coconut",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "15711D83-BC7C-47AD-B497-14A477CB2DC9",
                  "name": "Crab apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7562F0D6-9C53-4754-A815-CC0306A7F46B",
                  "name": "Cranberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E6F5F3A9-8F31-4635-BE22-C200097DCEC1",
                  "name": "Currant",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5B7EAF27-9595-455F-B222-542C8E5E2488",
                  "name": "Damson",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8E30BE01-9C6E-484B-B1B5-D537AB2F932B",
                  "name": "Date",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ACB41BEA-7C64-4069-A1BD-D13D8F806F42",
                  "name": "Durian",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B978606F-BD8D-41D1-8CA7-BE498CF8F31B",
                  "name": "Elderberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "777C9D11-6C83-420B-B0EA-82BD539C27EA",
                  "name": "Feijoa",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B074DE79-FB8F-4C5C-8661-03B2004E1550",
                  "name": "Fig",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7F365590-9F46-4079-B221-412673BC5E19",
                  "name": "Finger Lime (or Caviar Lime)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7EC242FC-42FF-4EF9-AFC2-E7DFE3555E14",
                  "name": "Gac",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D2177D28-AE45-4C30-94B5-428488DA04F3",
                  "name": "Goji berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "59C8E633-49EA-45A9-B679-32C3414BB4D0",
                  "name": "Gooseberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8DAA0E33-0D56-4427-A6BE-4E844098DFFC",
                  "name": "Grape",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8D94870E-AB59-4EB6-801A-3E888826F69C",
                  "name": "Raisin",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "03B89A87-F83C-4969-891B-3B524E38E98A",
                  "name": "Grapefruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D3E21F30-7829-452E-896C-60D07D77157B",
                  "name": "Grewia asiatica",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C8A1E029-15E7-4BEC-A6E5-FABA17C8E49A",
                  "name": "Guava",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BF650C9C-2579-4004-9E06-14884CEE7179",
                  "name": "Hala fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1CDE19F3-CB52-44B2-B108-F03743F4CDA3",
                  "name": "Haws",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8E629419-D73B-4E30-80CB-6FF0A99E4BE6",
                  "name": "fruit of Hawthorn",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6DA7B025-1331-454A-87AF-335AB5508B59",
                  "name": "Honeyberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F177F37A-6CDF-4CE7-BE2A-76EC4598097C",
                  "name": "Huckleberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "08B6E3D6-DCB5-4A01-8515-B5C9C022934A",
                  "name": "Jabuticaba (Plinia)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E705793C-3441-4B06-8F30-591D735EA065",
                  "name": "Jackfruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D93FBAD5-72B5-493D-B3AF-16F4EC12317F",
                  "name": "Jambul",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "31AC5147-6B89-4605-AC45-780337B28877",
                  "name": "Japanese plum",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "44F03171-CC27-40AD-BED3-BD4E519C096D",
                  "name": "Jostaberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "161250FF-44FA-4762-BEA9-68CF0AB8F432",
                  "name": "Jujube",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "34D71AC4-00EA-4C6B-9A1F-B19179BA5603",
                  "name": "Juniper berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "82BB3DCE-C521-437C-932A-1FEEB95FCFE4",
                  "name": "Kaffir lime",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1405B2A5-4C50-4F75-BF63-1BF8883B32F4",
                  "name": "Kiwano (horned melon)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A526EE1A-DF4A-4436-835A-1B68BFAA239F",
                  "name": "Kiwifruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E330174E-0035-41CE-A52D-0D2D486A4C79",
                  "name": "Kumquat",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6D1DE3EB-E169-4917-A73C-D7C22D49C04A",
                  "name": "Lanzones",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F7D4FD7A-D1DA-413B-920B-D106D10DFF5F",
                  "name": "Lemon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8C1AA574-9E3C-458A-99FA-C07FFF6DEC93",
                  "name": "Lime",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "24F9D158-B63C-4EEB-AD5F-126B45884561",
                  "name": "Loganberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "32F4D958-951A-423B-889C-280D0D894E89",
                  "name": "Longan",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D4F063FB-F826-44A5-BAE7-6BBF6701E9A3",
                  "name": "Loquat",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "184794A1-5323-435D-A66D-756226307204",
                  "name": "Lulo",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BF1A60A5-81AE-4FB6-8930-CC47FF22984F",
                  "name": "Lychee",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1E64CCA3-2AB5-44A6-BD76-2BF6C71661F3",
                  "name": "Magellan Barberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F1478F1C-BE7F-4515-B402-B076F9118AE2",
                  "name": "Macopa (Wax Apple)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4AE23A9F-6404-482E-9018-9C8A26D191EE",
                  "name": "Mamey apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "09DDD5D7-4C0F-4A77-965F-0490414D05C3",
                  "name": "Mamey Sapote",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "71E86AAD-D897-45A1-A1B6-A090546B8E58",
                  "name": "Mango",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A38A1F04-7FF3-4DF7-86BB-A0E32B37B90C",
                  "name": "Mangosteen",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AB82C55F-5B93-4D88-9A8B-934E1FA6111F",
                  "name": "Marionberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "854CE239-7E09-47BC-99DB-E435E431E82C",
                  "name": "Medlar",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B12BB817-062E-4EA3-953E-2E324C011E80",
                  "name": "Melon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8063A628-315D-479F-AD46-66AF1A9A36BA",
                  "name": "Cantaloupe",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A7179541-0EFA-4ABE-A9F1-D1BDD812A93C",
                  "name": "Galia melon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9C814016-665B-4715-8D50-51DB01E47096",
                  "name": "Honeydew",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6F0257DB-939A-42E1-835E-6B2864653098",
                  "name": "Mouse melon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "37988B78-EAC7-4779-8E5F-B046B5DBF0FA",
                  "name": "Muskmelon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1AFCA85C-07A6-459D-B2D9-8F7F8BB88443",
                  "name": "Watermelon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E3311B72-CDE3-4F87-8CC3-BA2225F84B9D",
                  "name": "Miracle fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7C5038B6-73D9-4BF4-8F9F-B961612F3B3E",
                  "name": "Mohsina",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F82C2F14-9A2E-46BE-A885-9DE18B99FA11",
                  "name": "Momordica fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4CF08ABD-34C6-4013-8E43-300EEEB918AA",
                  "name": "Monstera deliciosa",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A22C967B-8EB8-4E93-8D24-67C1FCAEC96B",
                  "name": "Mulberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4538F19D-1AFE-408E-808C-6CEEEACDDC99",
                  "name": "Nance",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DBC2B8BE-9108-4017-9D55-E46CF690AD06",
                  "name": "Nectarine",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5F151902-BC53-4D58-8BD3-0236F28A9035",
                  "name": "Orange",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9DACB795-64ED-4361-B40B-9BA81850A197",
                  "name": "Blood orange",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CD27343F-FB53-42A8-8212-4F72E373716E",
                  "name": "Clementine",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ABF1994F-F26E-4D16-9C73-48A65CD95BEA",
                  "name": "Mandarine",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5DADC37E-1BB4-40D6-A445-8A0EE78C37DD",
                  "name": "Tangerine",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8DEB6C6B-B963-49F6-8217-453FA39D7F94",
                  "name": "Papaya",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F12E7662-CEC6-42D5-96A5-FF58E272EF1C",
                  "name": "Passionfruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E7395BFD-82B6-45DF-86B1-F8B7AAD6A701",
                  "name": "Pawpaw",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7D4C807B-D376-4782-8B0E-9311048C78C3",
                  "name": "Peach",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EE6D97BA-ABDC-4D3B-868A-880CEBE2AD96",
                  "name": "Pear",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "230D018A-E4B3-4AB9-9AD0-05881AA95870",
                  "name": "Persimmon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A2DDEDEE-24FA-4C86-8C07-BBBA01697727",
                  "name": "Plantain",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ACD6628A-A057-4E35-9182-0B011EA78870",
                  "name": "Plum",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "12A01780-E783-400F-A9C1-B9F28BC8A1F8",
                  "name": "Prune (dried plum)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "33A6769B-FBE5-4325-ABD1-CE033087B371",
                  "name": "Pineapple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1E78ACC8-7251-4BFF-A37C-2257D48BC628",
                  "name": "Pineberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "486A463E-09A0-4B0F-A6D9-BBF22C2B4281",
                  "name": "Plumcot",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "69D4A4DA-9A25-4E87-88C0-8D05DB81B4A5",
                  "name": "Pomegranate",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FBC685BE-A665-40F8-9446-A48B3AB0BE9D",
                  "name": "Pomelo",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "15BF95E0-260D-43E9-B5E1-B22FAED62EAC",
                  "name": "Quince",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4DFF321D-320B-4DB4-AFA9-50E0AF757A3A",
                  "name": "Raspberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "598646F8-BE0A-4898-835D-FB2D42B39521",
                  "name": "Salmonberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "345CCFE5-CDFE-4DC2-8237-6F438FCB31A4",
                  "name": "Rambutan",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8EB60859-CC11-4E61-8578-01DA2FB5F81E",
                  "name": "Redcurrant",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "83B4B357-EE0C-4FF4-B818-29759399CABE",
                  "name": "Rose apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8982E2A2-2BE9-4668-9D68-627153867DAF",
                  "name": "Salal berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9317E2F9-F0C3-4F65-B5AA-5804BBA64472",
                  "name": "Salak",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BE7D37AE-A40D-4550-9E5C-E5229404E75F",
                  "name": "Santol",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "74A519F3-1656-4AB4-85A4-F02061E89A91",
                  "name": "Sapodilla",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "448BF5F0-804C-4760-897B-8D8F921EFC5D",
                  "name": "Sapote",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D0CEA965-FBD9-4840-A09C-A93DE9396315",
                  "name": "Sarguelas",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4BE6E291-02F7-44A0-8EC0-9FC12020F358",
                  "name": "Satsuma",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "69E385F1-1566-48B8-8B7E-AE8459D82785",
                  "name": "Sloe",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EDDA2947-47C7-49BA-A293-5D4C473E5B7B",
                  "name": "Soursop",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "38FF596F-F956-4D40-859A-DCE5079F50B2",
                  "name": "Star apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CC021F1F-461B-4C2C-8BCB-FC1DCBA2EFD0",
                  "name": "Star fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ADD37E28-8711-43DB-97BC-EED09D008AA1",
                  "name": "Strawberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9B81A6DC-038C-420D-8698-ADB52CC9DB85",
                  "name": "Sugar apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "68A899A5-5BD7-4717-8344-895EC1E7040A",
                  "name": "Suriname cherry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1AB3D259-FE44-43FF-B09A-802A09802036",
                  "name": "Tamarillo",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7BA9ADBE-B98A-4C75-974F-1DB415D96E91",
                  "name": "Tamarind",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "79FC7DCB-3539-4D1D-8496-4E887F44A0C2",
                  "name": "Tangelo",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8D31EDAF-13EA-4F4B-8981-CE4B27135080",
                  "name": "Tayberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "14622EED-552C-4DBA-B077-61667FB018AE",
                  "name": "Thimbleberry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "833B243B-1DA7-4165-8921-2E1E102A6679",
                  "name": "Ugli fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AEC4EE94-DFCE-4273-859A-20B39C5BDED8",
                  "name": "White currant",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B06AE2D4-E640-4FD9-ADCC-05EDBCB082EE",
                  "name": "White sapote",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "410A8033-2158-4FF1-B6E1-2C2F0826C1FE",
                  "name": "Ximenia",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7C5CE00B-462D-47A4-9830-71ACD2146820",
                  "name": "Yuzu",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BFB7EB73-38A1-419A-B508-06EBE9BFC57A",
                  "name": "Artichoke",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0BF142C6-029B-49DB-BF3E-76C4D8FFF37C",
                  "name": "Asparagus",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "23EA872C-4268-49C4-9880-995BBB05697E",
                  "name": "Broccoflower",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EB68D478-1FD9-43BC-BE89-385925C43FBB",
                  "name": "Broccoli",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1AAE4159-D1BC-4BF8-A534-51730AC691B0",
                  "name": "Brussels Sprouts",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A273CC5F-901D-4D4D-86B2-5CAB08E12735",
                  "name": "Cabbage",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F2DFC3ED-B0D9-4EF9-8FDB-CE92A6A0CAB7",
                  "name": "Kohlrabi",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "37F86EE3-BDE2-4D4E-B406-D104AE11AB82",
                  "name": "Savoy Cabbage",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D42BB755-90B5-4F88-BB5C-E80EEC7186CD",
                  "name": "Red Cabbage",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1C3E698B-08BA-48C4-9D38-7EBC1FA7BF46",
                  "name": "Sour Cabbage",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F54CCA4C-4CDF-4BD3-8830-FE5DF4D8774A",
                  "name": "Cauliflower",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AA2B3025-C416-49A1-87B2-4E705B9B9F5D",
                  "name": "Celery",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "84EE20EC-7C7E-4A82-9021-C7C23F11416C",
                  "name": "Chicory",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "37860E74-BECA-44B7-A10D-524E5CDD2E10",
                  "name": "Cilantro",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7AA1C464-5ADD-4E61-B4EA-609B0B4554AA",
                  "name": "Coriander",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C2BD0BB4-04FB-4DD3-8354-F66A61383EE1",
                  "name": "Eggplant",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4DFF4A24-1047-4B04-9F4B-DE0D75E6EA3F",
                  "name": "Endive",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "00C2B137-179A-499C-8037-6C2E3FD2C502",
                  "name": "Fiddleheads",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E771F3C7-1B94-4B98-B614-42F4857A6456",
                  "name": "Frisee",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2D1D6CB4-1396-4A69-B91B-48E5676C2E51",
                  "name": "Fennel",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "09379BFF-C6B8-4C99-BBB3-E4147D35E011",
                  "name": "Beet Greens",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "002078E6-267D-4E57-8E61-75406DA072BC",
                  "name": "Bok Choy",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6F6A1C0C-0209-4EDE-9D91-67B9D3BACB9B",
                  "name": "Chard",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "66BDCF92-E5D4-4777-A5BC-90192479F1EA",
                  "name": "Collard Greens",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BEB77F8C-9603-4BA3-8FC6-E64A8760A309",
                  "name": "Kale",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1A9F0D02-7016-43D2-B939-AD92C79E18C9",
                  "name": "Lettuce",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "295C4396-0107-4889-AC76-17985DE051BB",
                  "name": "Mustard Greens",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D226DE93-A831-49A8-B63A-76FEFC6462F1",
                  "name": "Spinach",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0DC11897-9912-4F45-8BB4-D2454051630A",
                  "name": "Alfalfa Sprouts",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D15CFDB9-36A9-4553-BCFC-D1E8CE2C1B7F",
                  "name": "Azuki Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "91AC6924-14A6-4627-A2C8-70559B11BAA8",
                  "name": "Bean Sprouts",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DA42F9A1-58E8-449A-9DA9-2AEEFAAF982E",
                  "name": "Black Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5801492F-5B6C-4C50-8F9E-BB7124861BA4",
                  "name": "Black-Eyed Peas",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "602B69C1-66D1-4627-BA2F-A16EDC53DC2B",
                  "name": "Borlotti Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BADF3085-79BC-4330-80C6-AADC6753BABA",
                  "name": "Broad Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8734CB1C-F8F4-4B29-A9E1-28276B7F156C",
                  "name": "Chickpeas (Garbanzos Beans)",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "806EE461-1E02-4771-954B-DF5EFAA0F719",
                  "name": "Green Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F48F810A-AF21-483D-BC4F-40FBBB4EA40C",
                  "name": "Kidney Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F0C8C481-CE89-4CBE-979E-8564A2A5E459",
                  "name": "Lentils",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A51AAE21-99CC-4E57-BA40-3C33382A0E56",
                  "name": "Lima Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0ADDAA8F-1E54-4EEA-8B65-D18C15DEC939",
                  "name": "Mung Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "91350433-6A83-4E8E-9C79-296CE76329B3",
                  "name": "Navy Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "43076C17-3C9F-436D-AE10-5F94306BD56A",
                  "name": "Peanuts",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C2B9CBA9-7DF9-45F8-9752-0371F1E64691",
                  "name": "Pinto Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "61F25E08-C453-4A2B-9844-2873716D4D31",
                  "name": "Runner Beans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0B6BAC77-E76F-4069-BCB2-A001E8CEDA60",
                  "name": "Split Peas",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3DD178EA-9ED7-449C-A78B-C7883528B5D5",
                  "name": "Soybeans",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F7E6EDD2-3219-44CA-B458-CBD257CAE8CD",
                  "name": "Peas",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4379C68D-504D-4857-9AE1-BD884199D9CD",
                  "name": "Snow Peas",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1E3E1EDC-5258-44A4-967F-72AB73066324",
                  "name": "Mushrooms",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "704C4A56-6407-4358-B3CF-781031191846",
                  "name": "Nettles",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0680191D-7FDF-44C8-AA27-A00B943FDAEB",
                  "name": "New Zealand Spinach",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EF838F4A-06B8-46C6-A4C3-49E66A1BD292",
                  "name": "Oca",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EFBD6795-551E-4712-8AE4-C0ED3EF7FD00",
                  "name": "Okra",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B91A4F88-6DCE-41E0-91A9-7CD39C46B218",
                  "name": "Onion Sprouts",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6564E311-9E3B-416D-A2B8-2F4974E05A81",
                  "name": "Chives",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1D0F3B41-45BC-431C-980F-166BAA95F58B",
                  "name": "Garlic",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6145302A-4661-41F9-8C75-7E5ACB258A2B",
                  "name": "Leek",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BE38754C-3F8D-40B0-917C-F7BB02F8F0B5",
                  "name": "Onion",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9C03388E-A8D1-44D7-9426-C40B479EDD36",
                  "name": "Shallot",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F573A711-26D6-47A2-B62F-2CE97EBCC15B",
                  "name": "Scallion",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "36450453-A913-467D-B785-AA93C5092AC7",
                  "name": "Bell Pepper",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "21C2EF91-9DDA-4617-B582-8ED269632F4A",
                  "name": "Chili Pepper",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ACB5F837-0DC3-4DC9-84F2-EFFC2111141E",
                  "name": "Jalapeño",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9DFA22A9-ED42-4AC0-B7C8-A8B24DA55FBE",
                  "name": "Habanero",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FBA17327-835B-4520-9E10-D82841746EA0",
                  "name": "Paprika",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C408CD09-5CC6-4AA1-83BC-3A7E484AF997",
                  "name": "Tabasco Pepper",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "07403F8A-040B-4C85-8BD6-77874D461393",
                  "name": "Cayenne Pepper",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C613446D-DB79-4B18-A786-6B719623D620",
                  "name": "Radicchio",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1C04716B-2764-406F-9A19-9CE4CA3CC5A6",
                  "name": "Rhubarb",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3E67AB58-67FA-4B4C-9192-E9BC5157C551",
                  "name": "Beetroot",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8E34B85B-A13E-422E-9940-79C5CE5DD254",
                  "name": "Carrot",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3ECDAD52-FEA8-46A4-9205-091DD7AF0D99",
                  "name": "Celeriac",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AB8DE5E5-327C-4247-B520-FD9C6E7011BD",
                  "name": "Corms",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "27B4AA61-87F1-44A6-B987-F7C75CA592FD",
                  "name": "Eddoe",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BF30B6B4-D1E7-4152-83A9-82CF6047C862",
                  "name": "Konjac",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C146FA4F-6620-4788-AEF4-E6DCC05BBE5C",
                  "name": "Taro",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9110E1F7-1BF2-4B6B-84ED-AAE5B2329C57",
                  "name": "Water Chestnut",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "23252669-D53B-4B6C-AD6D-7008D1F2B79A",
                  "name": "Ginger",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "072C897E-2871-4777-A93F-110F5E55866F",
                  "name": "Parsnip",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "15AAD9FF-3FA7-48DE-9E6C-1D18C9C60352",
                  "name": "Rutabaga",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "590EDCCC-F199-4DC8-A9E7-F5E47C9480AD",
                  "name": "Radish",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5C7D015A-EAC3-4892-9D9D-1F6E2EC31AE6",
                  "name": "Wasabi",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9B9FF50D-BA11-4C9D-86C5-47582F1DEA82",
                  "name": "Horseradish",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "05EEE039-18E4-47CB-8337-50F6541CB0B0",
                  "name": "Daikon",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1698B6AD-2FB9-4B12-A3D2-01D07D11A870",
                  "name": "Turnip",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "45FD1674-154B-4266-B7CF-B9CF9BBBF9E1",
                  "name": "Jicama",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EE3972F3-1B95-4733-8BEF-B482FC9E24E9",
                  "name": "Jerusalem Artichoke",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ECFA7A8A-899F-4340-8C0D-3AA92AC46478",
                  "name": "Kumara",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E3675917-BE45-4695-80D4-7D966EAE7036",
                  "name": "Potato",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B61DEE00-987C-46E1-94E3-7DE20AB17D23",
                  "name": "Sour Yam",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2D9F0652-7669-4641-BE08-B11D604D8B08",
                  "name": "Sweet Potato",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0E130766-A434-43B8-8920-BF92EADE6271",
                  "name": "Yam",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C3D7C7A4-6D0E-4560-B3C3-451105352803",
                  "name": "Salsify",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "379B0ABC-0F46-45AF-97BB-59EB43A25A3C",
                  "name": "Skirret",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5E8F770A-0641-4C6B-A96A-F0310857356E",
                  "name": "Succotash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B0622228-52B4-4F83-A646-010447F83F34",
                  "name": "Sweetcorn",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "39ACB836-38C2-4493-B799-C2B9F3073C7E",
                  "name": "Acorn Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "939B8B66-A0AF-4C6F-B5C9-E9C7BB56A712",
                  "name": "Bitter Melon",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C53B81C0-4705-497F-B30D-1D157B4629C3",
                  "name": "Butternut Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "06C215DD-7B27-447C-82AC-22914A88562D",
                  "name": "Banana Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "59AC0296-8C28-4DDE-8F05-446817E108FC",
                  "name": "Zucchini",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D619F2D8-3381-4219-9640-5198DED4801E",
                  "name": "Cucumber",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B943A8D0-FFB2-4C58-B828-00B6CCCB234A",
                  "name": "Delicata",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1CE6568F-60E5-4445-BF1B-316ECE8498BD",
                  "name": "Gem Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "174EAACB-C728-441E-95E3-ACCBE5B6A762",
                  "name": "Hubbard Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E90B3B00-90A8-486C-8314-F25AF7C3FB61",
                  "name": "Spaghetti Squash",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E002A24E-E119-49CE-85F1-61E11380289F",
                  "name": "Tat Soi",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "30A5EBBB-35B8-4050-8584-CB517A6AAE46",
                  "name": "Tomatillo",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1117A103-6740-4076-83EF-1158B3E4EB0D",
                  "name": "Tomato",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E1E4A7E5-F1D8-4095-97BD-BFF1072147BB",
                  "name": "Topinambur",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5756A1B1-7D51-4986-A06B-2374A7626AAE",
                  "name": "Watercress",
                  "category": "Vegetable",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FB8A4197-5672-474A-B563-39B751C8CF01",
                  "name": "Allspice",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "42164B5E-EAAC-4BEE-B421-0680EC8B6E40",
                  "name": "Anise",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F76473A8-1403-4C2F-8CD6-D7AA51F45AD2",
                  "name": "Aniseed",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "60C8811F-67D5-4A54-A45C-5EF01B091E11",
                  "name": "Asafoetida",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "97D14677-7ECD-4960-8A8D-B9F6D4DAC12C",
                  "name": "Basil",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "46DD8C1D-4DDD-4232-B52E-8FA69CEE2092",
                  "name": "Bay Leaves",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6FBAB77B-8E44-4474-8971-D037F26C8086",
                  "name": "Black Pepper",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1ADD9965-05CB-4F08-890A-0F45E529AFDF",
                  "name": "Black Seed",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D2449A83-B1D0-4956-81C4-C1FEBEA1F676",
                  "name": "Cardamom",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F9197AAE-255B-4820-915D-BB1C516B0443",
                  "name": "Skim Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DC2748E1-57F3-462A-ACA1-DCC592A591BA",
                  "name": "2% Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B57FAA59-6DAB-47B9-A98D-F7FA72FE10FB",
                  "name": "Almond Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5B96840E-B35D-445F-A084-82CEC2EFB68C",
                  "name": "Soya Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CA6FF7A9-0760-43D9-AE90-77452AE81FE7",
                  "name": "Cashew Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BFE87434-D4BB-4FBE-A589-EBFE1F034BEE",
                  "name": "Coconut Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8F54CF14-160D-47C7-B420-213482A2CA91",
                  "name": "Oat Milk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1E316DF4-A59F-4173-8D5B-2AEED65FD42F",
                  "name": "Cream",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2C5B771A-0DA8-481E-B108-18D9BA56A0EC",
                  "name": "Heavy Cream",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1F267758-C3F9-4F68-A99A-506D9FF89A78",
                  "name": "Whipping Cream",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "702D1F48-DCBA-4159-9AF7-D2520B432B76",
                  "name": "Half-And-Half",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F1614ECE-F2A6-4E9C-B4AB-D38465557E40",
                  "name": "Butter",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "03F16C00-3FD3-4CA6-9CF9-1DC6B1D92DB6",
                  "name": "Yogurt",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "623698F7-950F-4699-861C-AF1AEDCCD8F6",
                  "name": "Plain Yogurt",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9BB0DA3B-ACE6-4367-A573-993D81DF5693",
                  "name": "Greek Yogurt",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F2F4D053-9280-4499-9287-CD7735B3D4F4",
                  "name": "Mediterranean Yogourt",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BEB06C17-1D92-4C87-A577-12B8F97CEC2B",
                  "name": "Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "95899BBA-3FB3-481D-8991-10804C74F037",
                  "name": "Cheddar Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "683AF3D1-2FA6-47E8-86E7-70F9AABE7802",
                  "name": "Mozzarella Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2332397C-A6F3-4C22-8C1B-032744517DDC",
                  "name": "Swiss Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3625ECF2-206D-456E-B20C-B0BFE1FCBAE2",
                  "name": "Parmesan Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7BF0822F-C6D0-4031-9DE3-505DFC134F27",
                  "name": "Feta Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DA93388E-2D27-4E00-97CE-B6A4A0B5B196",
                  "name": "Brie Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FE96933D-0445-4EFA-926C-4DF7564D8212",
                  "name": "Ice Cream",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2199B0FD-0E83-4DEF-9BB3-1F4F6C6877D7",
                  "name": "Buttermilk",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "51A79EC9-9C69-4385-80C9-24C0119E2F1E",
                  "name": "Sour Cream",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ED8A38C0-6918-4A91-BF85-431DC625BC08",
                  "name": "Kefir",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AD47C95E-A86C-4FFD-BCAD-049E563A4349",
                  "name": "Cottage Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EE7B3BD0-38B6-496D-9FD2-4E37356155A2",
                  "name": "Ricotta Cheese",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "20F21CCA-5934-41E1-AEA1-89C32651C5EB",
                  "name": "Whey",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2428D247-1F48-48A8-AA6F-34296741DB0F",
                  "name": "Ghee",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E8CCC4E7-4ECA-4501-950D-43EE8FFD735B",
                  "name": "Mascarpone",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B1CA34EE-EB8A-4B89-AC58-50BA446BB33D",
                  "name": "Paneer",
                  "category": "Dairy",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EB1C4BD4-08FA-44C5-B66C-73E996633B00",
                  "name": "Eggs",
                  "category": "Egg",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F1ED5186-358F-486A-957B-2590A93992ED",
                  "name": "Egg Whites",
                  "category": "Egg",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "94F1D577-D8B6-4037-9F35-F32DF617596B",
                  "name": "Egg Yolks",
                  "category": "Egg",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E03262DA-12F7-4037-8B7E-DC69CDB31CA0",
                  "name": "Powdered Eggs",
                  "category": "Egg",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5CB2DCB9-F10A-45B9-B599-C6BBE29E2F0F",
                  "name": "Apple Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6A40AA84-79E9-4CA0-AF54-A86914C45C62",
                  "name": "Orange Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "53E65391-AF29-494C-B6BE-3B55BB387156",
                  "name": "Grapefruit Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AD9CF269-299B-41BA-B2E8-919D4C8F3A66",
                  "name": "Cranberry Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C3891998-7AF4-4C7F-8FBF-E418EAEA62BA",
                  "name": "Tomato Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0FEAECED-5C1D-48A7-8642-5670F3451E74",
                  "name": "Carrot Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B1FF99D6-E376-4BBD-8F65-1035D1A32B72",
                  "name": "Pineapple Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C29130FE-FC65-4880-81FE-2DB8249345C7",
                  "name": "Apple Cider",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "117FC5D5-FEC8-4BC2-B55A-74D2B7F6F442",
                  "name": "Grape Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3D247E20-2213-426F-A48C-A4D1C0A7D981",
                  "name": "Pomegranate Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1B121EF7-BA0A-4980-B3E3-F25B623E195F",
                  "name": "Blueberry Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4BC7C19B-46B7-462B-AEFE-10D70B3D7914",
                  "name": "Mango Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B0D96C1F-4F32-434E-8E18-015C52477F5B",
                  "name": "Peach Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "27D99FB4-3EFB-42C8-85F6-B874341D8372",
                  "name": "Pear Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E35B0A06-D328-4E6F-8D34-77E94C5789DB",
                  "name": "Watermelon Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F14D9C5D-6032-48AD-A50F-F8BE245A3301",
                  "name": "Vegetable Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A3218156-7F97-4B49-8194-101A556DF204",
                  "name": "Beet Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "57972EF4-43BC-42CE-A785-9B4F9F51C9FA",
                  "name": "Celery Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7928C57B-E6F4-4AE4-8FAF-DA5C825F851B",
                  "name": "Lemon Juice",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5E43D698-CA77-4748-8615-4C560BD7EF6F",
                  "name": "Lime Juicemeats",
                  "category": "Juice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "34A8B474-6A4B-46B2-A9B1-7350D313D877",
                  "name": "Beef",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CC9575E6-7697-4936-9A49-3B63C117BEA8",
                  "name": "Ground Beef",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D5A2CBC3-4BDA-464D-BD64-970E177F9D26",
                  "name": "Ribs",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8F86ED9F-1535-4119-942C-0ADBA6459DB8",
                  "name": "Brisket",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8746A92E-D7F4-4E03-93B3-FE48A41950E7",
                  "name": "Roast Beef",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1BD215CF-1111-4670-B75F-2F676BDF5AB5",
                  "name": "Pork Chops",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E95E355F-90D0-4BDA-96CE-CE07E437BDE5",
                  "name": "Bacon",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "57818370-0B2B-4FCA-9480-96DDAFDF31EF",
                  "name": "Ham",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A554479E-712B-4A72-A30D-936BE6ADF883",
                  "name": "Sausage",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "79BF0688-A5EA-4CB4-9D62-EDBB267F0B2C",
                  "name": "Ground Pork",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "34D880DE-3D9E-4FE4-81D0-CC251FC747F0",
                  "name": "Chicken",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F5CBC2BC-C775-45A5-A333-A1ACF38D20D8",
                  "name": "Turkey",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "850C75A3-9522-476C-8330-EECF59FEA1EF",
                  "name": "Duck",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "68C75BBC-9344-495A-9099-F18F2A93E647",
                  "name": "Goose",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "128B27F6-14C1-4CC8-A641-323EE964968A",
                  "name": "Lamb",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5D1E86BA-763F-47E5-99DF-8CACC461B885",
                  "name": "Lamb Chops",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4459329D-7E47-4D73-8501-D4BE3C0F2BD2",
                  "name": "Ground Lamb",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EF2A7531-6586-4F02-A026-437DAC7C2CF2",
                  "name": "Leg Of Lamb",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1557A37E-A818-44A5-B57D-35DF77A7CFC8",
                  "name": "Fish",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9E83DC7E-D686-4CD5-B3F4-155DB2509979",
                  "name": "Salmon",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FD352889-DEC1-4184-8CD4-06B8E510E412",
                  "name": "Tuna",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "34310043-CC23-4086-BFC5-F595DDEDF5DA",
                  "name": "Cod",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8E63AA00-37D0-45AF-9E4D-DC1F85B9C123",
                  "name": "Shellfish",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DA6EBD86-529D-4EB9-9F74-1D4B6869E6E3",
                  "name": "Shrimp",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1A1C3115-FE4B-4BD8-BDD3-9F3D00FF00E3",
                  "name": "Crab",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "24A7DE61-FCA2-436B-9906-217B03CF519F",
                  "name": "Lobster",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3128094E-87B4-45E4-909A-C6464D58FC2B",
                  "name": "Squid",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "68BB23FB-DE47-40A7-9F4A-0C93E9E568CA",
                  "name": "Octopus",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1E40692D-B3D6-4585-83C0-F281E92984DF",
                  "name": "Venison",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CD0181A4-8325-4E3F-8BB2-AC1C3AA77FE7",
                  "name": "Elk",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F0ADA35A-5DBB-4C21-AB7C-7BA6F7325A58",
                  "name": "Bison",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "08026DD4-AAFC-4354-A508-FADDD5C36A5D",
                  "name": "Tofu",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3C74C9FF-15FB-48BF-88F5-1C5541553A6E",
                  "name": "Tempeh",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E3B5C3A5-2F4E-4E42-A227-2AB1DD31F4EF",
                  "name": "Seitan",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "69BECE02-1AD7-457D-8CE0-E6CAFA85026A",
                  "name": "Veggie Burgers",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7F85FCA8-AF3E-4B1B-8A5B-A05BA426CA93",
                  "name": "Veggie Sausages",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C1E7A829-00F2-4124-AAA0-70E28E7D2BE9",
                  "name": "Veggie Bacon",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F43F5B09-DE3F-41E5-997B-B371200CB35B",
                  "name": "Veggie Chicken",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D6E6DDAC-7E73-47B2-ACC4-CBA6473C8C87",
                  "name": "Veggie Ground Meat",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DBF15975-DF9E-4452-B91E-FDB140045AA8",
                  "name": "Impossible Foods",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "513B40F9-A26E-41EC-B839-10F413E4DD3E",
                  "name": "Beyond Meat",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2379FE9A-0470-4023-B695-20D4AB8B2618",
                  "name": "Gardein",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F88FAF8A-F0E3-4538-8D4A-71948E044511",
                  "name": "Morningstar Farms",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "94A28CF7-B51F-432B-9EFC-F7B96E4849EB",
                  "name": "Field Roast",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "87446B5D-3A0C-419D-B540-953BAFE3F329",
                  "name": "Tofurky",
                  "category": "Meat",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "69262C16-D86B-4426-BC22-C20E3657A901",
                  "name": "Canned Tomatoes",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "60ACE2AF-49FA-4567-BCB3-9422667E5142",
                  "name": "Canned Tomato Sauce",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DBC33230-6A00-490A-80B0-13823BCFBF0F",
                  "name": "Canned Tomato Paste",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "903662D3-6AFE-491F-B9D9-6852AD840D49",
                  "name": "Canned Green Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "74CEC1C6-0504-4D13-898A-796C678450BA",
                  "name": "Canned Corn",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "14ED51D9-8880-41D2-A33C-CB45E94F6CBD",
                  "name": "Canned Peas",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5C4BC350-5177-4E92-A188-910D5F10F3CE",
                  "name": "Canned Carrots",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CD1965F0-0CCE-44A8-8033-CD24DA5DCBD9",
                  "name": "Canned Mushrooms",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2FCC7D19-5004-4EDA-9325-0FBAF098D0B7",
                  "name": "Canned Olives",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "515D40BB-FEBF-434B-8990-4ECC1BD5FD60",
                  "name": "Black Olives",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2B3E97A3-AA38-4DB5-A5FD-B7BFC203C64D",
                  "name": "Green Olives",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "56C84A80-9752-4058-B388-BE3D9EAA12AD",
                  "name": "Canned Artichoke Hearts",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "36C5AEDF-53EC-46EB-9BF6-7C9E5DCB3F60",
                  "name": "Canned Asparagus",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C9724736-9C25-481A-ACAE-C4E75714C4F5",
                  "name": "Canned Beets",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D68B2217-BE5B-4F59-BE2E-DC7F01F3D599",
                  "name": "Canned Spinach",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "75ACC6F4-EECD-477F-A796-59BD7FAB6CE6",
                  "name": "Canned Pumpkin",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A626E07D-8489-43B9-B871-F2EC54E5F3CE",
                  "name": "Canned Sweet Potatoes",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "414D9BCC-AD06-4248-8EDC-DB18E44C6140",
                  "name": "Canned Peaches",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F66BC23D-EB23-418B-8011-DA52829000EC",
                  "name": "Canned Pears",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "358AF9AE-AE44-4F3C-9D59-9F12174D13D7",
                  "name": "Canned Pineapple",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C0D77F06-4BCC-432F-B6CC-005A764469BB",
                  "name": "Canned Mandarin Oranges",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AECF8057-E89C-4C0E-99DB-70379B76678E",
                  "name": "Canned Fruit Cocktail",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C2EEAC36-775A-4400-AFE9-D0BCA35C80EF",
                  "name": "Canned Cherries",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5F4E37A4-632A-455F-AB99-07F3330D51DF",
                  "name": "Canned Grapefruit",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "825AB6CD-4029-40F6-84FA-6CB3B3DB3CF2",
                  "name": "Canned Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "529D6F97-96DB-4444-9621-13741B37FE4D",
                  "name": "Chickpeas",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "66B1E6C7-0879-49DD-940A-3FE9E1DCD6F1",
                  "name": "Garbanzo Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2C112AF7-0400-4445-BE5D-6B5848206151",
                  "name": "Canned Tuna",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F860D7E0-2929-4452-B82C-36E7FA1E684F",
                  "name": "Canned Salmon",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "76D0DA65-6BCD-465B-B1F8-8277EEBEAA0C",
                  "name": "Canned Sardines",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AD23574E-49B9-4A43-B538-62FCAE19C363",
                  "name": "Canned Chicken",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FBFB1D9A-E93E-4E44-A98C-2B139B8BBE7D",
                  "name": "Canned Soups",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9AECD81C-02D3-486C-8797-7F74EDFC1A76",
                  "name": "Chicken Noodle Soup",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F6338EA8-AD9A-499C-A911-B357074AB69D",
                  "name": "Tomato Soup",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "70AD6B85-3F91-4402-BA6E-4AF3846380BC",
                  "name": "Vegetable Soup",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E93D67CA-5767-4AF4-B86C-96116652B33C",
                  "name": "Canned Broth",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B29C2B22-F321-4148-B90B-40B77FC0CDCA",
                  "name": "Chicken Broth",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C10F06A7-2A83-4C15-B58E-0247A0FCF1FE",
                  "name": "Vegetable Broth",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9B1E73F3-81CE-4497-8E3D-91A01A812877",
                  "name": "Canned Coconut Milk",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "12B8CCFE-84AE-45A1-8BAC-0DC31CC1141D",
                  "name": "Salt",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6E57498D-9DB0-417F-8857-E6C60747F65B",
                  "name": "Ketchup",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F297FB58-27F1-421F-9393-E7B36D0DB82D",
                  "name": "Yellow Mustard",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "101B0014-BBF0-4E3D-A8ED-B7710B188AC3",
                  "name": "Dijon Mustard",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FFA079C7-BEF5-4996-A15F-D7DA90B9FE17",
                  "name": "Mayonnaise",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3D74BB32-E2E4-4AB0-8EE4-6B9B4EC26171",
                  "name": "Barbecue Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "89B07B39-1DD7-4539-B42E-4A7F3A2FFC73",
                  "name": "Sriracha",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "57009A07-0274-4AD6-A2DA-72E7DC6E7B99",
                  "name": "Tabasco",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2BAD3D92-C31C-43C3-81B9-A04CD840D302",
                  "name": "Red Hot",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "028014F1-0EB4-4462-AA80-83A9C971C486",
                  "name": "Soy Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E4B80A51-8F60-4DB9-BE71-8A4261E3CD21",
                  "name": "Teriyaki Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7A8B0F19-2DA4-4E09-8CD5-924FB5B512B8",
                  "name": "Worcestershire Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "88B0566C-21E2-41AD-BB41-574EBD2ADF77",
                  "name": "Hoisin Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3413BBE8-D613-4E10-8BF2-84792A147B7C",
                  "name": "Oyster Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D58CFC95-10FB-4DC0-BE8D-58F5CA7AD8A7",
                  "name": "Fish Sauce",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D378EEB8-2FB9-46CE-8356-6113613E8DF0",
                  "name": "Marinades",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "60E5A0F5-E048-4FDB-81EC-04BDB0F9C966",
                  "name": "Salad Dressings",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "13AF4CA0-C71E-493E-8B93-592719B04F93",
                  "name": "Pesto",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F29509A1-5274-47D3-8D0C-22B479A735BE",
                  "name": "Chimichurri",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "53F5943F-25DB-4926-A779-5F3516F3134F",
                  "name": "Guacamole",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A14A31D5-BEC7-4F1F-A6B2-09630BEDE99A",
                  "name": "Salsa",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9857FF8B-7579-4C3B-89DF-0DACF0C3E111",
                  "name": "Hummus",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D33C3200-C5C8-48E2-AC97-F3B22E80F2FB",
                  "name": "Honey",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "261BA3FD-5EF0-4EDF-B8FF-DD08A59360C9",
                  "name": "Maple Syrup",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "80184E1C-C483-4DC6-9E3D-0784CB2E0843",
                  "name": "Jam",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1984E59D-8618-47C6-A090-5F7B8EE7650A",
                  "name": "Jelly",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "27443396-B2FA-42C2-9DAD-EDBDF449E642",
                  "name": "Marmalade",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9A2C041A-45EF-48D6-9C7C-FBAFC06E6A46",
                  "name": "Chocolate Syrup",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "030EFD21-46E5-4492-8284-D724EFEE4ED4",
                  "name": "Caramel Syrup",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "025FBB7D-0698-4D43-8DA3-F73212D751BF",
                  "name": "Chocolate Spread",
                  "category": "Sauce",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B09E648D-94C9-42B1-8736-8F5CF66C4B28",
                  "name": "Abiu",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "ACB3D8FC-FF82-4778-B35C-6A9BF32991EE",
                  "name": "Akebi",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3D04DB84-0FBD-4360-A4F2-C5566BDFE3E9",
                  "name": "Buddha's Hand (Fingered Citron)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "83BD82A3-81F0-449C-8ADC-2BBE23EE72C6",
                  "name": "Cactus Pear",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4265BACC-419C-4A4F-8802-567202A0A177",
                  "name": "Canistel - Also Called Egg Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "562A9801-CC14-4D5D-BF99-1FB73E624C4D",
                  "name": "Chico Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4A3F6B22-46AB-4E20-83CD-85AED64F4230",
                  "name": "Coco De Mer",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "66A2EAB1-9D63-4CC3-BA22-CF0E51CDDBD8",
                  "name": "Crab Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5009CF83-9FD2-4EC0-879C-65FAD6BAD214",
                  "name": "Dragonfruit (Or Pitaya)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A9FCE0CC-0BDC-42A3-83D6-2F7E0A2ECF52",
                  "name": "Finger Lime (Or Caviar Lime)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D413061D-C805-4033-8BEA-B8231B3FAC92",
                  "name": "Goji Berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B65DB644-8965-4BC8-9F99-67DF78DCB930",
                  "name": "Grewia Asiatica",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "01F8EB59-2136-499D-BDA6-A7DCC28B577F",
                  "name": "Hala Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FA0EECE9-CF9D-42AD-A871-4F28BE84CBFA",
                  "name": "Fruit Of Hawthorn",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9DF93277-562D-41E9-916F-C9AE94A8ADC2",
                  "name": "Japanese Plum",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FC8167DE-1606-42DE-9488-E01655C9B2E5",
                  "name": "Juniper Berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "31E6EDFC-F2FE-49B1-9DF9-57B16360054E",
                  "name": "Kaffir Lime",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BAB6DE1A-4CEB-4663-AA6A-DC3C4FAD3636",
                  "name": "Kiwano (Horned Melon)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "47CD2BA1-9550-4A7A-BA59-BDF5B7F721E2",
                  "name": "Mamey Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BD85470D-7E72-4F04-BA92-7A45C19AD718",
                  "name": "Galia Melon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "65DFA29D-E018-4B7E-BDCA-DA4521026AC4",
                  "name": "Mouse Melon",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A28DAE68-B1E5-4EA1-8358-7D8406EBE841",
                  "name": "Miracle Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D87F751A-9F68-4A70-A0F7-68808290E015",
                  "name": "Momordica Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "54C20A80-9B7F-4304-9BF9-83CF04D304DC",
                  "name": "Monstera Deliciosa",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B1476BED-F4D1-4A38-A5FD-AB7D84A3953F",
                  "name": "Blood Orange",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2901D7FD-BF92-4C86-B372-036C5E9C47C8",
                  "name": "Prune (Dried Plum)",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CB0580CF-DA7A-422C-A4DA-AB474680C5BB",
                  "name": "Rose Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0B7631B3-AF58-47DA-9BAF-889966C44B6F",
                  "name": "Salal Berry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7044AAAE-3DA0-4B69-9015-9505243DAB8C",
                  "name": "Star Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F8FFA08F-DBC0-481D-BEB4-C5BD560A15F5",
                  "name": "Star Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B073B711-92B9-479D-BB8B-C9E626B7C4AB",
                  "name": "Sugar Apple",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0E3D8C80-0AB1-4B88-9E96-4FD2F2FD81B5",
                  "name": "Suriname Cherry",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "83075E57-13F8-4FB8-9547-441F3C6DD882",
                  "name": "Ugli Fruit",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "15B79278-0795-4A63-8A38-3C6CEE7C069C",
                  "name": "White Currant",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E2BF242B-2FED-4297-8987-54F55FE0454E",
                  "name": "White Sapote",
                  "category": "Fruit",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9D5790B0-9337-4DC7-9731-2B06C1F1939C",
                  "name": "Cayenne Pepper",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6669759F-4958-4A7C-B944-FAB149F276FB",
                  "name": "Celery Seed",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "500B6287-A7D9-42F2-8D22-D3C8BA018640",
                  "name": "Chili Powder",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D5377B0A-59F9-48BF-B236-A4B024C04FA7",
                  "name": "Chives",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "93948C4D-DF58-414F-B500-56F202F24CD2",
                  "name": "Cinnamon",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9F2477A7-2ADE-46C0-AD9E-5C7C35512499",
                  "name": "Cloves",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F0A37ABE-3B49-40CE-A356-985128EA2BD7",
                  "name": "Coriander",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6D71841F-55AC-4135-9B73-D94D6BC90A21",
                  "name": "Cumin",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AC587E87-7C2B-4BA0-90FD-9FB8B77A0E74",
                  "name": "Curry Powder",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5BE9E3DD-D08B-44F5-8F25-E1078BEAE4B9",
                  "name": "Dill",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3F42B134-2DCD-47D3-877E-753223CD0310",
                  "name": "Dill Seed",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0BCE4529-66ED-4BBA-ACA8-CFBF17D41B34",
                  "name": "Fennel",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FA3579BE-B176-498B-8C35-147FDAD1441B",
                  "name": "Fenugreek",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "90808275-9389-4F00-B697-D1700665DF97",
                  "name": "Garlic Powder",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8377E6CD-DC80-4203-80D1-486958128D20",
                  "name": "Ginger",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "032ABBC4-5B4E-4687-A4FA-C7A40AF9D41E",
                  "name": "Ginger Powder",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "92CF07F2-C341-4401-A09D-55F6EB154E54",
                  "name": "Ground Cloves",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7FEFA986-28C6-4B98-B9B2-55F0E5499BD6",
                  "name": "Ground Cumin",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "55791437-3543-44AA-936A-24245D73836B",
                  "name": "Ground Nutmeg",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0495FA93-90E0-40F9-9492-8CBDECA4B6BD",
                  "name": "Ground Turmeric",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8ED396FE-B2A5-4EE0-B58A-CEF8661C978D",
                  "name": "Juniper Berries",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "987E6B24-A93A-4751-AAFA-1904B9C2BBEB",
                  "name": "Laurel Leaves",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C330FF1B-CBE3-4090-9F16-F3669A61EEA0",
                  "name": "Mace",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "87E2B708-BE59-4773-92DA-9B8E5372FA02",
                  "name": "Marjoram",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FDAADC47-CB0D-480F-9734-3A57E9E813F3",
                  "name": "Mustard Seed",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5E023A1E-708F-4FB4-A3CD-1CAD344041E7",
                  "name": "Nutmeg",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A73FEC84-9189-415C-B0A7-3F69D80A024A",
                  "name": "Onion Powder",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A3D18FB0-020E-4B2A-961F-6E97A4202D09",
                  "name": "Oregano",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5CBF8E13-C1B5-45FD-8145-DA3BA575C19A",
                  "name": "Paprika",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4F6721FD-2C51-47EB-AC9A-1CBFA2102FA1",
                  "name": "Parsley",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CB209585-6375-4E33-B466-6E8E699DF638",
                  "name": "Peppercorns",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "106CB061-CB3C-4116-BD8A-C01F94EB5311",
                  "name": "Pink Peppercorns",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "04325561-2E3D-4F3E-B9BA-0CF7BE7D5CF9",
                  "name": "Poppy Seeds",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D2A22166-CB7E-460F-866D-18091A7DE03E",
                  "name": "Red Pepper Flakes",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A4E1D8B8-47E0-4204-AC34-83354BDF8E51",
                  "name": "Rosemary",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F37DF0FF-9D7F-4823-A2F4-A962BF90D02A",
                  "name": "Saffron",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5FA0345E-54E2-4058-AE1A-D1DD1F73F98B",
                  "name": "Sage",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DFDD196A-9F45-48B5-A8AA-C5572522A1A2",
                  "name": "Savory",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "16ED7529-6F72-474D-B699-5C3113E8D056",
                  "name": "Sesame Seeds",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "01C6FC38-E136-4EE9-A4DC-92356C384A6D",
                  "name": "Star Anise",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2E4A2CEE-C705-49D3-B404-F263174B5659",
                  "name": "Tarragon",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FA793C04-85C3-434C-AB12-CC7D06079073",
                  "name": "Thyme",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "75AC576D-3233-475A-A530-C53929570FF0",
                  "name": "Turmeric",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "35D9D2B4-03E9-44F5-B098-1DE276730FC9",
                  "name": "Vanilla",
                  "category": "Spice",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "448A095A-441B-4535-9A49-7EEF289487C9",
                  "name": "Black Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C4C05658-66A3-4601-8F56-51602BCC2324",
                  "name": "Kidney Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0C7085D4-5C11-42F9-978B-8B263C9EC7BB",
                  "name": "Pinto Beans",
                  "category": "Canned Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "33B336CD-6830-4396-AA4A-B077B90D51F3",
                  "name": "Almonds",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "061B375E-866B-4939-B441-96717BD55D38",
                  "name": "Brazil Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D643032B-3C96-4FB9-90AE-640385EA6355",
                  "name": "Cashews",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AB0260C6-8C78-41A3-BDA6-FCFA53A1D640",
                  "name": "Chestnuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C05B83C1-E6B1-49BB-9409-01BD7E403413",
                  "name": "Hazelnuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EC3DCD51-764C-41B3-B70A-367F81924F97",
                  "name": "Macadamia Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "35974F05-76E5-4B6F-9277-5F4E122789B7",
                  "name": "Pecans",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E1C97633-3E96-4EA6-A823-276CC3E23E8B",
                  "name": "Pine Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9B59B287-5D0B-4C13-91EA-D73CDBAB9F9D",
                  "name": "Pistachios",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2FC03312-ED90-479A-8C13-397D27E6B9D6",
                  "name": "Walnuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FEA645A0-4419-4767-AFCC-2BC60FB6CAB2",
                  "name": "Hickory Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D0C34FCD-C9F1-4A3E-8898-9F563D327444",
                  "name": "Beechnuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EE9ABCE2-9835-4303-AED4-521053C220E6",
                  "name": "Ginkgo Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "33EEA472-C651-477A-8D24-ECF13AF7E905",
                  "name": "Kola Nuts",
                  "category": "Nut",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A6501189-5013-4888-A242-E12547FED306",
                  "name": "Chia Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F8088713-E5B7-4D23-B09B-49EC7AC76317",
                  "name": "Flaxseeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4B046815-008F-49AB-890B-57059B5B9E6F",
                  "name": "Hemp Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BFBC7E02-7715-4E06-AB29-1DBACBA1B165",
                  "name": "Pumpkin Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B9F2A3F1-8327-47C1-B5C4-5DDD2B101205",
                  "name": "Sesame Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EBB00D8A-2449-4581-81CD-B41C49AA7688",
                  "name": "Sunflower Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3D9BFA9F-A3FA-45B5-AD45-B57D2830040C",
                  "name": "Poppy Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "957755EA-D999-4316-93E0-E3F4BF7673D3",
                  "name": "Nigella Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "692BDC0B-0792-4225-87C5-1AA05A481BF6",
                  "name": "Mustard Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "631EE4E5-6983-476F-B265-2F9090053AAA",
                  "name": "Cumin Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D7B3F74A-1198-4BBE-BC67-BC06EAC47444",
                  "name": "Fennel Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "37E737AE-5D14-4C0F-ACC9-0E638A32FBF9",
                  "name": "Caraway Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6742B8B6-31B9-4B17-A15E-F65810095F6D",
                  "name": "Coriander Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8426095D-3F52-410F-B06A-6CDF4EA251E8",
                  "name": "Watermelon Seeds",
                  "category": "Seed",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5AFD3254-753E-4247-9083-8FEE7BB3E4DC",
                  "name": "Apple Cider Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FCF34A22-7502-486B-845E-457E6DE6FE4B",
                  "name": "Balsamic Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C4130404-E1C8-4FAB-A794-49C3C974E91B",
                  "name": "White Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "13DC4F32-6C6E-4557-8EAC-AD729AE8812A",
                  "name": "White Wine Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "292C9450-DA01-4C92-9D6A-130D7AA40648",
                  "name": "Red Wine Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "46764E8C-9FB8-43D3-82F9-8244A20F7457",
                  "name": "Rice Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "377D0175-3309-43F9-B0DA-E255F5A79130",
                  "name": "Sherry Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DD004F4B-A81E-4CEF-A34E-C3BE155CB220",
                  "name": "Champagne Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E30CEC69-D842-4DED-954E-25A8DA9087A8",
                  "name": "Malt Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "842BC2FD-1680-47A8-8CAD-3D22EDBD7EEC",
                  "name": "Coconut Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A571F30A-C59B-4365-A4B7-DD1CC6F2C33C",
                  "name": "Cane Vinegar",
                  "category": "Vinegar",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D8CFF022-B50A-4367-8782-FC53AE630E9D",
                  "name": "Olive Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3B1AD378-4272-41C6-9A51-65B151A1BFB2",
                  "name": "Extra Virgin Olive Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BD79F5D5-E814-45C1-A169-908D023401B7",
                  "name": "Canola Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "59FFEECF-5B6E-405A-9481-C5DB238A8F6A",
                  "name": "Vegetable Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DEDA4EBD-188D-4E03-9B8C-FE46F6180EF8",
                  "name": "Sunflower Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4286A6B9-873F-4F09-B374-87C672CDD457",
                  "name": "Corn Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "553463AB-E99B-47A5-82C0-281F2A19E195",
                  "name": "Peanut Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "80201AE2-7C2B-4EB3-ABFD-5BB922A48FA1",
                  "name": "Sesame Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "29B7DB25-6341-475E-A5F6-BB9786AE917B",
                  "name": "Coconut Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5781D6C5-9EA6-4B26-930B-D835137A9EB5",
                  "name": "Avocado Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "58509FD0-96BE-4EAD-BA79-0C4E4BB71562",
                  "name": "Walnut Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7E9D33A9-7D01-4CEA-A40E-27E0FE30A036",
                  "name": "Grapeseed Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8D030640-DB2B-4AA7-94B4-16800ED168CB",
                  "name": "Flaxseed Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E48225B4-6EED-4A3D-963D-28072819ACF3",
                  "name": "Safflower Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6A14E07E-25A3-41CB-92C6-5C738D2EBDDE",
                  "name": "Palm Oil",
                  "category": "Oil",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "17A66737-09E2-4CAA-BFDD-1839155A6585",
                  "name": "All-Purpose Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7ACEB5C6-4F0F-4B85-852E-F17D7A53A18F",
                  "name": "Whole Wheat Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "59B8E04B-87B9-457A-8CDE-B69BB6C35379",
                  "name": "Almond Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B27042C9-BC01-48D1-816E-624FD8D5311E",
                  "name": "Coconut Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E4200121-25A9-461E-9DE1-C813D092DEDF",
                  "name": "Bread Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EB071482-3CC3-4B62-9366-1D7CED01F06C",
                  "name": "Cake Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "69E63738-FC4F-4429-AD3B-10AC4971163E",
                  "name": "Pastry Flour",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C666DA87-7D52-4BB3-8D9D-67F68C2BFFC2",
                  "name": "Baking Powder",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "07B0E635-FDE2-4324-AB75-62BEADF758D7",
                  "name": "Baking Soda",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C008A03E-6210-49CE-B2FF-C065B4DA5F4A",
                  "name": "Yeast",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CB003CA5-2700-4AB9-BF0E-92FF38729D94",
                  "name": "Cornstarch",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "76F93DA1-1357-4CEE-AC79-CE9507486611",
                  "name": "Cocoa Powder",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5E6513B2-5DFD-4BC4-8B19-ADF170502351",
                  "name": "Granulated Sugar",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "1CE83385-36D9-494E-94A7-FFC2BFF38F68",
                  "name": "Powdered Sugar",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BE2B16DA-673D-40FF-92DC-D116AA4A1BE3",
                  "name": "Brown Sugar",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6D7A6F51-0E70-4A9B-9BFF-1E69865E509C",
                  "name": "Raw Sugar",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DD02F5B3-0D55-4E5C-B2C1-B7E7EA278464",
                  "name": "Honey",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3DF61BBE-D392-4B1C-B9BB-532483D2A4A3",
                  "name": "Maple Syrup",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8C381439-5F31-45B3-994E-4B33E458D5E3",
                  "name": "Molasses",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B80665B9-DBF0-4643-98E8-76888496B68E",
                  "name": "Vanilla Extract",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6701E413-4A6C-44A8-8197-99D8516A4AB6",
                  "name": "Chocolate Chips",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EB4C462F-A38C-4B81-B2B9-C10BC07CE982",
                  "name": "Shortening",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D37A3C40-1C44-4B6D-B4EF-B9A8AD6C657F",
                  "name": "Butter",
                  "category": "Baking",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6957248B-212D-49EE-90E5-49DE8DEBBAAD",
                  "name": "Frozen Peas",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0E80061C-512C-499D-9741-FAF7FFA518DD",
                  "name": "Frozen Carrots",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DF5BB0AF-06F6-45AF-B7A8-85AA22B1E0DF",
                  "name": "Frozen Spinach",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C72F4167-2116-4DE1-BEC6-0C031E32F4B9",
                  "name": "Frozen Broccoli",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C3907AD0-43A2-4D67-9D47-A7DF413ABEDD",
                  "name": "Frozen Cauliflower",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0E626DDA-ACCF-450F-AB30-D8FF14E7C266",
                  "name": "Frozen Mixed Vegetables",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E51BB7EB-8BD0-4ED1-82F0-509E70029723",
                  "name": "Frozen Strawberries",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9B9560A3-5FE3-409B-8296-9AA71DBF70AC",
                  "name": "Frozen Blueberries",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AC602445-A88F-42A0-AE54-0A793AA65EE6",
                  "name": "Frozen Mango",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0FC6436B-0215-41CA-A47D-62A47A73FEC5",
                  "name": "Frozen Raspberries",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6799F073-BEC9-493E-8D74-50C9277ED787",
                  "name": "Frozen Sweetcorn",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D42D78BD-CF45-43C0-9518-1D4BDBA48AE4",
                  "name": "Frozen French Fries",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AE177AED-3C8F-42E4-AB3C-7FB145B2D7D0",
                  "name": "Frozen Dumplings",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D29D844F-09B0-4941-ABC7-ACC1B6CE6D81",
                  "name": "Ice Cream",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "0F972BE3-7969-4826-A763-7281991EFAA8",
                  "name": "Sorbet",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7B68C6DC-D484-4EFA-A977-EF06962F7B17",
                  "name": "Frozen Yogurt",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C94D8B83-6D22-4277-B77E-A86827BC4245",
                  "name": "Frozen Fish Fillets",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FC48FC4E-2769-4497-AE39-42097D91310B",
                  "name": "Frozen Chicken Nuggets",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "649DBA1D-27AE-487C-B5AA-2CCBEF13AC0D",
                  "name": "Frozen Shrimp",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "417391CE-3404-45DB-8725-B0934FB42347",
                  "name": "Sushi Grade Salmon",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CEC91EE0-E06F-45CD-9DBD-83A4FB435ECA",
                  "name": "Sushi Grade Tuna",
                  "category": "Frozen",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7F1A4CFE-F7FA-4F7B-9301-C600E5898375",
                  "name": "White Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "DDED24AD-C954-4895-A163-701C0C54C36A",
                  "name": "Brown Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C55F5F01-84A6-490E-A2F6-76B411029757",
                  "name": "Basmati Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "898EB75D-01EE-4E0F-9F0F-8885D1C87027",
                  "name": "Jasmine Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "02F92138-5A0B-49C1-9F05-E130F58800E0",
                  "name": "Arborio Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C3A92868-D565-4C5F-9F7F-157337A39312",
                  "name": "Wild Rice",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6008C4B9-428E-4853-8F74-2E476E0A1217",
                  "name": "Quinoa",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "31048958-D172-41BC-AA55-30BB92C0BF90",
                  "name": "Bulgur",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3612F052-EC97-47C8-99B9-24E49D71F440",
                  "name": "Couscous",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4D4AB93F-D3B4-40AE-9B8B-CF619918FF51",
                  "name": "Barley",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FAF388E2-B49A-420F-9C60-B364CBBEB3A0",
                  "name": "Farro",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3861A398-550C-4711-9D69-FC0F18CE5139",
                  "name": "Rolled Oats",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A41DEB0D-724E-4308-B9FD-92C6AAF4E2A6",
                  "name": "Steel-Cut Oats",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7D9F622C-6126-4883-888D-80BE2F9116AB",
                  "name": "Instant Oats",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "16D5ADEA-87D5-419D-AB1C-C4D4D16B3166",
                  "name": "Millet",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "83684864-CC20-4B41-BD9E-27FC595B0263",
                  "name": "Rye",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "58847BE0-029B-4757-A67C-768CBB53BFF8",
                  "name": "Sorghum",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "754DD516-E38F-4F3F-BF53-F5D9069FC3B6",
                  "name": "Spelt",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "898B712E-56C7-4B1F-98D3-68EB7B1ADCDE",
                  "name": "Cornmeal",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "10C2A1AB-06BB-4BE7-BBBA-C9644BD2CDBA",
                  "name": "Polenta",
                  "category": "Rice, Grains & Cereals",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D9FFF9EE-30BB-4BA4-BA87-064B799DBAC7",
                  "name": "Spaghetti",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "40D1A35E-3016-434F-B918-A955A77575B2",
                  "name": "Penne",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E06D6E42-67AC-4AA8-900F-DC958A8C6DCB",
                  "name": "Macaroni",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "47D72127-1545-4EB7-94F9-45AD7EFACEB6",
                  "name": "Instant Noodles",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B53988DB-A95A-4CE9-B146-1C5FF77B2EE9",
                  "name": "Lentils",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5001A19D-48A9-4171-9404-47A8BFFABF09",
                  "name": "Chickpeas",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CC9AA804-1786-4CE3-8139-6207C97589EF",
                  "name": "Split Peas",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "8589A2D7-5E99-434F-BAEC-0EA950075913",
                  "name": "Black Beans",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "A87410BB-4768-49FE-B2FD-F587BBEBDEC9",
                  "name": "Kidney Beans",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "87D102C4-3991-4FAC-A0C6-93AFED3E0288",
                  "name": "Cannellini Beans",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "093B63A7-37AE-46F3-AE61-A0FEE556B429",
                  "name": "Raisins",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F5B1D9D7-35B2-4183-8268-47C59DB653F1",
                  "name": "Dried Apricots",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "44CD3C7B-E856-4E15-A91B-AA40DFB4A61B",
                  "name": "Dates",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CDCF84A1-201F-434F-B563-258EFEF15273",
                  "name": "Prunes",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "64AE5E23-ECB2-4B3E-9945-40FEE645B884",
                  "name": "Rice Cakes",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "41A78B63-0F97-485E-B704-764FB91D4AF7",
                  "name": "Crackers",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "97171C85-BA5A-485B-94AE-1F1EA2680A9A",
                  "name": "Granola",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4975B8E0-5074-4E91-8E27-C98387EE67AC",
                  "name": "Trail Mix",
                  "category": "Dry Food",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "5C23CEE3-BA07-437D-A1EF-576E704977F3",
                  "name": "Prosciutto",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "78CDBFFA-CCEB-4580-BC5F-0A83AD71341A",
                  "name": "Salami",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "CF2FFAA8-378A-4A03-B8DE-DC8712742A3F",
                  "name": "Chorizo",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4A0502CB-E70F-43F7-95F6-80DB86D80AEA",
                  "name": "Soppressata",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D1E3EE79-F442-48F9-8C64-3DC58273BA17",
                  "name": "Pepperoni",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EA07FF63-7A88-4696-8BB1-8BF6D2CC5BB4",
                  "name": "Mortadella",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "71AB591D-CBE8-4DFB-AC21-285B78538374",
                  "name": "Bresaola",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E6329B51-F491-445E-A3D6-1ADC8C4B5EA5",
                  "name": "Capicola",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "2793CF05-5D6C-40E1-9DE0-7664AA78C829",
                  "name": "Jamón Serrano",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3816327A-6F72-4554-AF6C-91D39273CD64",
                  "name": "Pancetta",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "9F47CAA7-1CE1-4854-8018-4FF82C3B2644",
                  "name": "Coppa",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "4FDEE8D5-FBCD-44BA-8463-497023B29671",
                  "name": "Lomo",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "735FB5EE-A3A2-4500-A878-AF1730DFBCC1",
                  "name": "Pâté",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F8C87599-EB10-41C6-84A7-B462A7A8640C",
                  "name": "Terrine",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "26D78F59-AD8E-4CBE-810F-4994CEFF54B1",
                  "name": "Rillettes",
                  "category": "Charcuterie",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "EB168558-3030-4D4C-87F3-53983445FAAF",
                  "name": "Basil",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B29AD9CA-AC5B-46BD-B94E-7EFFDF2BEA3E",
                  "name": "Mint",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BC793DAF-06D0-431C-AC34-15CE1D6CB177",
                  "name": "Cilantro",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "E6E73B78-73A5-4353-BD96-37C2C063B0E1",
                  "name": "Parsley",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "C8ECD47B-9764-4B35-8588-40A0A356DA05",
                  "name": "Dill",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3BAFED97-B507-47F5-8BEE-1C33EB8C5AA1",
                  "name": "Thyme",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "7FD5C529-76A3-4D4E-8174-B31A6574D0EB",
                  "name": "Rosemary",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "FDE40DE7-D804-4B04-82E0-DE894756F0B4",
                  "name": "Oregano",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "B8FFABF0-F0DA-47ED-887E-8CF670E60900",
                  "name": "Sage",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "6914AD47-A240-4A40-8A5D-E15A721FCE5C",
                  "name": "Chives",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "3688D470-500F-4879-9C91-E5E73BC817D6",
                  "name": "Tarragon",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "46456B39-2ECE-4989-A25D-BFFB06778847",
                  "name": "Marjoram",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "BEC49852-E311-4A91-91E8-078589718D79",
                  "name": "Bay Leaves",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "31DEC2A1-15B7-4AD1-B520-11EC009C0F51",
                  "name": "Lovage",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "AD1DEBA0-ACC0-4D78-A2E9-500BB7E4CC74",
                  "name": "Lemon Balm",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "471442D7-6AE8-40BC-AA1C-53C76ECF6B5B",
                  "name": "Sorrel",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "D7AE605E-C6AC-472F-937C-91034E7E9EDD",
                  "name": "Savory",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "F65ADDFA-0AC3-4D04-981E-E93750AC139D",
                  "name": "Curry Leaves",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                },
                {
                  "_id": "49D01806-54E5-46B4-A082-DF24CCC99DFF",
                  "name": "Epazote",
                  "category": "Fresh Herb",
                  "allergens": [],
                  "__v": 0
                }]
                """.data(using: .utf8)!
        
        do {
            let items = try decoder.decode([FoodItem].self, from: FOOD_ITEMS_JSON)
            DispatchQueue.main.async {
                self.foodItems = items
            }
        } catch {
            print("func loadFoodItems() - Error decoding JSON: \(error)")
        }
    }
}

