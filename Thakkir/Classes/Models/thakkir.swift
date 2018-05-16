//
//	thakkir.swift
//	Model file Generated using Realm Object Editor: https://github.com/Ahmed-Ali/RealmObjectEditor
import RealmSwift
import Foundation

class Thakkir : Object{
    @objc dynamic var fajrTime : Date  = Date()
    @objc dynamic var sunriseTime : Date = Date()
    @objc dynamic var dhuhrTime : Date = Date()
    @objc dynamic var asrTime : Date =  Date()
    @objc dynamic var maghribTime : Date =  Date()
    @objc dynamic var ishaTime : Date =  Date()
    @objc dynamic var fajrPray : Bool = false
    @objc dynamic var dhuhrPray : Bool = false
    @objc dynamic var asrPray : Bool = false
    @objc dynamic var maghribPray : Bool = false
    @objc dynamic var ishaPray : Bool = false
    @objc dynamic var fajrSona : Bool = false
    @objc dynamic var dhuhrSona : Bool = false
    @objc dynamic var asrSona : Bool = false
    @objc dynamic var maghribSona : Bool = false
    @objc dynamic var ishaSona : Bool = false
    @objc dynamic var sunriseSona : Bool = false
    @objc dynamic var fajrGamaa : Bool = false
    @objc dynamic var dhuhrGamaa : Bool = false
    @objc dynamic var asrGamaa : Bool = false
    @objc dynamic var maghribGamaa : Bool = false
    @objc dynamic var ishaGamaa : Bool = false
    @objc dynamic var fajrTasbeeh : Bool = false
    @objc dynamic var dhuhrTasbeeh : Bool = false
    @objc dynamic var asrTasbeeh : Bool = false
    @objc dynamic var maghribTasbeeh : Bool = false
    @objc dynamic var ishaTasbeeh : Bool = false
    @objc dynamic var salatQeyam : Bool = false
    @objc dynamic var salatTahagod : Bool = false
    @objc dynamic var salatNehayetElSalat: Bool = false
    
    
    @objc dynamic var fajrEstagfar : Bool = false
    @objc dynamic var dhuhrEstagfar : Bool = false
    @objc dynamic var asrEstagfar: Bool = false
    @objc dynamic var maghribEstagfar : Bool = false
    @objc dynamic var ishaEstagfar : Bool = false
    
    
    @objc dynamic var Quran1 : Bool = false
    @objc dynamic var Quran2 : Bool = false
    @objc dynamic var Quran3 : Bool = false
    @objc dynamic var Quran4 : Bool = false
    @objc dynamic var Quran5 : Bool = false
    @objc dynamic var DayMelady : Date  =  Date()
    @objc dynamic var id : Int = 0
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
        let RetNext = Array(realm.objects(Thakkir.self).sorted(byKeyPath: "id"))
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
