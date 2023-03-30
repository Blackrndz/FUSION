/* ****************************************************************************
 * $Revision: 80147 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-02-10 17:07:26 +0700 (Fri, 10 Feb 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Inventory%20Organization%20Locations%20-%20United%20States.sql $:
 * $Id: Manage Inventory Organization Locations - United States.sql 80147 2023-02-10 10:07:26Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


-- RSC_PREREQUISITE_OBJECTS=PAY_INSTALLED_LEGISLATIONS
 
SELECT Head.location_name RES_NAME
,Head.INTERNAL_LOCATION_CODE RES_CODE
,Head.SET_NAME RES_LOCATION_SET

,Head.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Head.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Head.CREATED_BY RSC_CREATED_BY
,Head.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,Head.inventory_organization_id RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT LocationDetailTranslationDEO.LOCATION_CODE
	, LocationEO.INTERNAL_LOCATION_CODE
	, LocationDetailDEO.ACTIVE_STATUS
	, SetIdSetPEO.SET_NAME
	--, TerritoryPEO.TERRITORY_SHORT_NAME
	, AddressDPEO.TOWN_OR_CITY
	, AddressDPEO.POSTAL_CODE
	, InventoryOrganization.ORGANIZATION_NAME
	, ShippingLocation.LOCATION_CODE AS LOCATION_CODE1
	, LanguagePEO.DESCRIPTION
	, LocationDetailDEO.OFFICE_SITE_FLAG
	, LocationDetailDEO.SHIP_TO_SITE_FLAG
	, LocationDetailDEO.RECEIVING_SITE_FLAG
	, LocationDetailDEO.BILL_TO_SITE_FLAG
	, AddressDPEO.ADDRESS_LINE_1
	, AddressDPEO.ADDRESS_LINE_3
	, AddressDPEO.ADDL_ADDRESS_ATTRIBUTE4
	, AddressDPEO.REGION_1
	--, TimezonePEO.NAME
	, AddressDPEO.TIMEZONE_CODE
	, LocationEO.SET_ID
	, LocationDetailDEO.LOCATION_DETAILS_ID
	, LocationDetailTranslationDEO.LANGUAGE
	, LocationEO.LOCATION_ID
	, SetIdSetPEO.SET_ID                               AS SET_ID1
	, LocationDetailTranslationDEO.LOCATION_DETAILS_ID AS LOCATION_DETAILS_ID1
	, LanguagePEO.LANGUAGE_CODE
	, InventoryOrganization.ORGANIZATION_ID
	, LocationEO.LOCATION_IMAGE_URL
	, AddressDPEO.address_line_2
	, AddressDPEO.region_2
	, LocationDetailDEO.geo_hierarchy_node_id
	, AddressDPEO.COUNTRY
	,(ROWNUM)                      AS MAP_SEQUENCE
	, ShippingLocation.LOCATION_ID AS LOCATION_ID1
	, AddressDPEO.ADDRESS_ID
	--, TerritoryPEO.TERRITORY_CODE
	,(AddressDPEO.GEOMETRY.SDO_POINT.X) AS LOC_LONGITUDE
	,(AddressDPEO.GEOMETRY.SDO_POINT.Y) AS LOC_LATITUDE
	, LocationEO.OBJECT_VERSION_NUMBER
	--, TimezonePEO.TIMEZONE_CODE AS TIMEZONE_CODE1
	, LocationDetailTranslationDEO.DESCRIPTION DESCRIPTION_LOC
	,ShippingLocation.email_address
	,LocationDetailTranslationDEO.location_code CODE
	,LocationDetailTranslationDEO.location_name
	,ShippingLocation.designated_receiver_id
	,LocationDetailDEO.mainphone_country_code1
	,LocationDetailDEO.mainphone_area_code1
	,LocationDetailDEO.mainphone_subscriber_num1
	,LocationDetailDEO.mainphone_extension1
	,LocationDetailDEO.fax_country_code2
	,LocationDetailDEO.fax_area_code2
	,LocationDetailDEO.fax_subscriber_num2
	,LocationDetailDEO.fax_extension2
	,LocationDetailDEO.otherphone_country_code3
	,LocationDetailDEO.otherphone_area_code3
	,LocationDetailDEO.otherphone_subscriber_num3
	,LocationDetailDEO.otherphone_extension3
	,LocationDetailDEO.ship_to_location_id
	,LocationDetailTranslationDEO.ac_location_code
	,LocationEO.last_updated_by
	,LocationEO.last_update_date
	,LocationEO.CREATED_BY
	,LocationEO.CREATION_DATE
	,LocationDetailDEO.EFFECTIVE_START_DATE
	,LocationDetailDEO.EFFECTIVE_END_DATE
	,LocationDetailDEO.Business_group_id
	,LocationDetailDEO.inventory_organization_id
	,LocationEO.action_occurrence_id
	FROM fusion.PER_LOCATIONS LocationEO
	, fusion.PER_LOCATION_DETAILS_F LocationDetailDEO
	, fusion.PER_LOCATION_DETAILS_F_TL LocationDetailTranslationDEO
	, fusion.PER_LOC_ADDRESS_USAGES_F LocationAddressUsageDEO
	, fusion.FND_LANGUAGES_VL LanguagePEO
	, fusion.INV_ORGANIZATION_DEFINITIONS_V InventoryOrganization
	, fusion.FND_SETID_SETS_VL SetIdSetPEO
	, fusion.HR_LOCATIONS_ALL_F_VL ShippingLocation
	, fusion.PER_ADDRESSES_F AddressDPEO
	--, fusion.FND_TERRITORIES_VL TerritoryPEO
	--, fusion.FND_TIMEZONES_VL TimezonePEO
	WHERE(((((((((((LocationEO.LOCATION_ID           = LocationDetailDEO.LOCATION_ID)
	AND((LocationDetailDEO.LOCATION_DETAILS_ID       = LocationDetailTranslationDEO.LOCATION_DETAILS_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE       = LocationDetailTranslationDEO.EFFECTIVE_START_DATE)
	AND(LocationDetailDEO.EFFECTIVE_END_DATE        = LocationDetailTranslationDEO.EFFECTIVE_END_DATE )))
	AND(LocationDetailTranslationDEO.LANGUAGE        = userenv('LANG')))
	AND(LocationEO.LOCATION_ID                       = LocationAddressUsageDEO.LOCATION_ID))
	AND(LanguagePEO.LANGUAGE_CODE (+)                = LocationDetailDEO.OFFICIAL_LANGUAGE_CODE))
	AND(LocationDetailDEO.INVENTORY_ORGANIZATION_ID  = InventoryOrganization.ORGANIZATION_ID(+)))
	AND(LocationEO.SET_ID                            = SetIdSetPEO.SET_ID))
	AND((LocationAddressUsageDEO.ADDRESS_USAGE_TYPE  = 'MAIN')
	AND(LocationAddressUsageDEO.EFFECTIVE_START_DATE = LocationDetailDEO.EFFECTIVE_START_DATE)))
	AND((LocationDetailDEO.SHIP_TO_LOCATION_ID       = ShippingLocation.LOCATION_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE BETWEEN ShippingLocation.EFFECTIVE_START_DATE AND
		ShippingLocation.EFFECTIVE_END_DATE)))
	AND((LocationDetailDEO.MAIN_ADDRESS_ID     = AddressDPEO.ADDRESS_ID)
	AND(LocationDetailDEO.EFFECTIVE_START_DATE = AddressDPEO.EFFECTIVE_START_DATE)))
	--AND(TerritoryPEO.TERRITORY_CODE            = AddressDPEO.COUNTRY)
	)
	--AND(AddressDPEO.TIMEZONE_CODE              = TimezonePEO.TIMEZONE_CODE(+))
	AND SYSDATE BETWEEN LocationDetailDEO.EFFECTIVE_START_DATE AND LocationDetailDEO.EFFECTIVE_END_DATE
	) HEAD
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.lle_information6
	,AAA.lle_information7
	,AAA.attribute1
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_MWS_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) Work_Site
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND */AAA.lle_information_category = 'HRX_US_REPORTING_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) Report
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_VETS_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) Veteran
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.lle_information3
	,AAA.lle_information4
	,AAA.lle_information5
	,AAA.lle_information6
	,AAA.lle_information7
	,AAA.lle_information8
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_EEO1_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) EEO
,(SELECT AAA.location_id
	,AAA.lle_information1
	,AAA.lle_information2
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_X AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_PA_PSD_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) PSD
,(SELECT AAA.location_id
	,AAA.attribute_number1
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_UNEMPLOYMENT_REPORTING'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) UN_EMPLOY
,(SELECT AAA.location_id
	,AAA.lle_information_number1
	,AAA.lle_information_number2
	,AAA.EFFECTIVE_START_DATE
	,AAA.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F AAA
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*AAA.location_id            = BBB.location_id
	AND*/ AAA.lle_information_category = 'HRX_US_VETS_INFORMATION'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN AAA.EFFECTIVE_START_DATE(+) AND AAA.EFFECTIVE_END_DATE(+)))*/
	) EMP
,(SELECT AA.location_name
	, CC.location_id
	, CC.EFFECTIVE_START_DATE
	, CC.EFFECTIVE_END_DATE
	,(SELECT INTERNAL_LOCATION_CODE
		FROM PER_LOCATIONS
		WHERE LOCATION_ID = BB.LOCATION_ID) LOCATION_CODE
	FROM fusion.PER_LOCATION_DETAILS_F_TL AA
	,fusion.PER_LOCATION_DETAILS_F BB
	,fusion.PER_LOCATION_DETAILS_F CC
	WHERE AA.location_details_id = BB.location_details_id
	AND AA.LANGUAGE = USERENV('LANG')
	AND AA.EFFECTIVE_START_DATE = BB.EFFECTIVE_START_DATE
	AND AA.EFFECTIVE_END_DATE = BB.EFFECTIVE_END_DATE
	AND BB.location_id = CC.ship_to_location_id
	AND((CC.EFFECTIVE_START_DATE BETWEEN AA.EFFECTIVE_START_DATE(+) AND AA.EFFECTIVE_END_DATE(+))
	AND(CC.EFFECTIVE_END_DATE BETWEEN AA.EFFECTIVE_START_DATE(+) AND AA.EFFECTIVE_END_DATE(+)))
	) Ship_LOC
,(SELECT LocationLegislativeEFFDEO.LOCATION_ID
	, LocationLegislativeEFFDEO.LLE_INFORMATION1
	,(
		(SELECT SUBSTR(hl.location_name,1,50)
		FROM fusion.PER_LOCATION_LEG_F pll
		, fusion.hr_locations_all hl
		WHERE(pll.location_id    = hl.location_id
		AND pll.Lle_Information1 = 'Y'
		AND hl.active_status     = 'A'
		AND pll.LLE_INFORMATION_CATEGORY LIKE 'HRX_US_LOC_EEO_VETS_INF')
		AND(hl.location_id = LocationLegislativeEFFDEO.LLE_INFORMATION_NUMBER1
		AND ROWNUM         = 1)
		)) HR_REPORT
	,LocationLegislativeEFFDEO.EFFECTIVE_START_DATE
	,LocationLegislativeEFFDEO.EFFECTIVE_END_DATE
	FROM fusion.PER_LOCATION_LEG_F LocationLegislativeEFFDEO
	--,fusion.PER_LOCATION_DETAILS_F BBB
	WHERE /*LocationLegislativeEFFDEO.location_id            = BBB.location_id
	AND*/ LocationLegislativeEFFDEO.LLE_INFORMATION_CATEGORY = 'HRX_US_LOC_EEO_VETS_INF'
	/*AND((BBB.EFFECTIVE_START_DATE BETWEEN LocationLegislativeEFFDEO.EFFECTIVE_START_DATE(+) AND
		LocationLegislativeEFFDEO.EFFECTIVE_END_DATE(+))
	AND(BBB.EFFECTIVE_END_DATE BETWEEN LocationLegislativeEFFDEO.EFFECTIVE_START_DATE(+) AND
		LocationLegislativeEFFDEO.EFFECTIVE_END_DATE(+)))*/
	) HR_PROXY
,PAY_INSTALLED_LEGISLATIONS AddressFormatE0
WHERE((HEAD.location_id = Work_Site.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Work_Site.EFFECTIVE_START_DATE(+) AND Work_Site.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Work_Site.EFFECTIVE_START_DATE(+) AND Work_Site.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Report.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Report.EFFECTIVE_START_DATE(+) AND Report.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Report.EFFECTIVE_START_DATE(+) AND Report.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Veteran.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Veteran.EFFECTIVE_START_DATE(+) AND Veteran.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Veteran.EFFECTIVE_START_DATE(+) AND Veteran.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = EEO.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN EEO.EFFECTIVE_START_DATE(+) AND EEO.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN EEO.EFFECTIVE_START_DATE(+) AND EEO.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = PSD.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN PSD.EFFECTIVE_START_DATE(+) AND PSD.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN PSD.EFFECTIVE_START_DATE(+) AND PSD.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = UN_EMPLOY.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN UN_EMPLOY.EFFECTIVE_START_DATE(+) AND UN_EMPLOY.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN UN_EMPLOY.EFFECTIVE_START_DATE(+) AND UN_EMPLOY.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = EMP.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN EMP.EFFECTIVE_START_DATE(+) AND EMP.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN EMP.EFFECTIVE_START_DATE(+) AND EMP.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = HR_PROXY.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN HR_PROXY.EFFECTIVE_START_DATE(+) AND HR_PROXY.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN HR_PROXY.EFFECTIVE_START_DATE(+) AND HR_PROXY.EFFECTIVE_END_DATE(+))))
AND((HEAD.location_id = Ship_LOC.location_id(+))
AND((HEAD.EFFECTIVE_START_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))
AND(HEAD.EFFECTIVE_END_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))))
AND head.country = AddressFormatE0.LEGISLATION_CODE(+)
AND head.country = 'US'
ORDER BY RES_NAME
,RES_CODE