//
//	thakkir.swift
//	Model file Generated using Realm Object Editor: https://github.com/Ahmed-Ali/RealmObjectEditor
import RealmSwift
import Foundation

class Thakkir : Object{
    dynamic var fajrTime : Date  = Date()
    dynamic var sunriseTime : Date = Date()
    dynamic var dhuhrTime : Date = Date()
    dynamic var asrTime : Date =  Date()
    dynamic var maghribTime : Date =  Date()
    dynamic var ishaTime : Date =  Date()
    dynamic var fajrPray : Bool = false
    dynamic var dhuhrPray : Bool = false
    dynamic var asrPray : Bool = false
    dynamic var maghribPray : Bool = false
    dynamic var ishaPray : Bool = false
    dynamic var fajrSona : Bool = false
    dynamic var dhuhrSona : Bool = false
    dynamic var asrSona : Bool = false
    dynamic var maghribSona : Bool = false
    dynamic var ishaSona : Bool = false
    dynamic var sunriseSona : Bool = false
    dynamic var fajrGamaa : Bool = false
    dynamic var dhuhrGamaa : Bool = false
    dynamic var asrGamaa : Bool = false
    dynamic var maghribGamaa : Bool = false
    dynamic var ishaGamaa : Bool = false
    dynamic var fajrTasbeeh : Bool = false
    dynamic var dhuhrTasbeeh : Bool = false
    dynamic var asrTasbeeh : Bool = false
    dynamic var maghribTasbeeh : Bool = false
    dynamic var ishaTasbeeh : Bool = false
    dynamic var salatQeyam : Bool = false
    dynamic var salatTahagod : Bool = false
    dynamic var salatNehayetElSalat: Bool = false
    
    
    dynamic var fajrEstagfar : Bool = false
    dynamic var dhuhrEstagfar : Bool = false
    dynamic var asrEstagfar: Bool = false
    dynamic var maghribEstagfar : Bool = false
    dynamic var ishaEstagfar : Bool = false
    
    
    dynamic var Quran1 : Bool = false
    dynamic var Quran2 : Bool = false
    dynamic var Quran3 : Bool = false
    dynamic var Quran4 : Bool = false
    dynamic var Quran5 : Bool = false
    dynamic var DayMelady : Date  =  Date()
    dynamic var id : Int = 0
    //
    //	override class func primaryKey() -> String
    //	{
    //		return "id"
    //	}
    //
    
    override static func indexedProperties() -> [String] {
        return ["DayMelady","id"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //Incrementa ID
    func IncrementaID() -> Int{
        let realm = try! Realm()
        let RetNext = Array(realm.objects(Thakkir).sorted(byKeyPath: "id"))
        let last = RetNext.last
        if RetNext.count > 0 {
            let valor = (last as AnyObject).value(forKey: "id") as? Int
            return valor! + 1
        } else {
            return 1
        }
    }
    
    
    //	override class func attributesForProperty(propertyName: String) -> RLMPropertyAttributes
    //    {
    //		var attrs = super.attributesForProperty(propertyName)
    //		var indexedProperties = [String]()
    //		indexedProperties.append("DayMelady")
    //		indexedProperties.append("DayHejry")
    //
    //		if find(indexedProperties, propertyName) != nil{
    //			attrs |= RLMPropertyAttributes.AttributeIndexed
    //		}
    //
    //		return attrs
    //	}
    
}
