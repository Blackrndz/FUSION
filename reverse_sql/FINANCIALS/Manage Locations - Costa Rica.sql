/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PAY_INSTALLED_LEGISLATIONS
 
WITH SHIP_LOC AS(SELECT CC.SHIP_TO_LOCATION_ID LOCATION_ID
    ,CC.EFFECTIVE_START_DATE
    ,CC.EFFECTIVE_END_DATE
    ,(SELECT LOCATION_NAME
        FROM PER_LOCATION_DETAILS_F_VL
        WHERE LOCATION_ID = CC.SHIP_TO_LOCATION_ID
        AND CC.EFFECTIVE_END_DATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE 
        ) LOCATION_NAME
    ,(SELECT INTERNAL_LOCATION_CODE
        FROM PER_LOCATIONS
        WHERE LOCATION_ID = CC.SHIP_TO_LOCATION_ID
        ) LOCATION_CODE
    FROM PER_LOCATION_DETAILS_F CC)
 
SELECT location_name RES_NAME
,INTERNAL_LOCATION_CODE RES_CODE
,SET_NAME RES_LOCATION_SET
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT Head.location_name 
	,Head.INTERNAL_LOCATION_CODE 
	,Head.EFFECTIVE_START_DATE
	,Ship_LOC.LOCATION_ID
	,Head.SET_NAME
	,ROW_NUMBER() OVER(PARTITION BY Head.location_name ,Head.INTERNAL_LOCATION_CODE ORDER BY Head.CREATION_DATE) R1
	,Head.LAST_UPDATED_BY
	,Head.LAST_UPDATE_DATE
	,Head.CREATED_BY
	,Head.CREATION_DATE
	FROM
		(SELECT LocationDetailTranslationDEO.LOCATION_CODE
		,LocationEO.INTERNAL_LOCATION_CODE
		,AddressDPEO.COUNTRY
		,LocationEO.LOCATION_ID
		,LocationDetailTranslationDEO.location_code CODE
		,LocationDetailTranslationDEO.location_name
		,LocationDetailDEO.EFFECTIVE_START_DATE
		,LocationDetailDEO.EFFECTIVE_END_DATE
		,SetIdSetPEO.SET_NAME
		,LocationEO.last_updated_by
		,LocationEO.last_update_date
		,LocationEO.CREATED_BY
		,LocationEO.CREATION_DATE
		FROM fusion.PER_LOCATIONS LocationEO
		, fusion.PER_LOCATION_DETAILS_F LocationDetailDEO
		, fusion.PER_LOCATION_DETAILS_F_TL LocationDetailTranslationDEO
		, fusion.PER_LOC_ADDRESS_USAGES_F LocationAddressUsageDEO
		, fusion.FND_SETID_SETS_VL SetIdSetPEO
		, fusion.HR_LOCATIONS_ALL_F_VL ShippingLocation
		, fusion.PER_ADDRESSES_F AddressDPEO
		WHERE((((((((((LocationEO.LOCATION_ID           = LocationDetailDEO.LOCATION_ID)
		AND((LocationDetailDEO.LOCATION_DETAILS_ID       = LocationDetailTranslationDEO.LOCATION_DETAILS_ID)
		AND(LocationDetailDEO.EFFECTIVE_START_DATE       = LocationDetailTranslationDEO.EFFECTIVE_START_DATE)))
		AND(LocationDetailTranslationDEO.LANGUAGE        = userenv('LANG')))
		AND(LocationEO.LOCATION_ID                       = LocationAddressUsageDEO.LOCATION_ID))))
		AND(LocationEO.SET_ID                            = SetIdSetPEO.SET_ID))
		AND((LocationAddressUsageDEO.ADDRESS_USAGE_TYPE  = 'MAIN')
		AND(LocationAddressUsageDEO.EFFECTIVE_START_DATE = LocationDetailDEO.EFFECTIVE_START_DATE)))
		AND((LocationDetailDEO.SHIP_TO_LOCATION_ID       = ShippingLocation.LOCATION_ID)
		AND(LocationDetailDEO.EFFECTIVE_START_DATE BETWEEN ShippingLocation.EFFECTIVE_START_DATE AND
			ShippingLocation.EFFECTIVE_END_DATE)))
		AND((LocationDetailDEO.MAIN_ADDRESS_ID     = AddressDPEO.ADDRESS_ID)
		AND(LocationDetailDEO.EFFECTIVE_START_DATE = AddressDPEO.EFFECTIVE_START_DATE)))
		) HEAD
	,SHIP_LOC Ship_LOC
	WHERE (HEAD.LOCATION_ID = Ship_LOC.location_id(+)
		AND HEAD.EFFECTIVE_END_DATE BETWEEN Ship_LOC.EFFECTIVE_START_DATE(+) AND Ship_LOC.EFFECTIVE_END_DATE(+))
	AND head.country = 'CR'
	) QTRLS
WHERE R1 = 1

ORDER BY (CASE
	WHEN EXISTS (SELECT 1 FROM PER_LOCATIONS WHERE LOCATION_ID = QTRLS.LOCATION_ID) THEN	1
	ELSE 2 
	END)
,RES_NAME
,RES_CODE