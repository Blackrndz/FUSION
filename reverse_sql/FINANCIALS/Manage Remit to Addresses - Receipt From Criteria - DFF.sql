/* ****************************************************************************
 * $Revision: 79612 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-11-10 16:08:02 +0700 (Thu, 10 Nov 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Remit%20to%20Addresses%20-%20Receipt%20From%20Criteria%20-%20DFF.sql $:
 * $Id: Manage Remit to Addresses - Receipt From Criteria - DFF.sql 79612 2022-11-10 09:08:02Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=222##RES##RA_REMIT_TOS
-- DFF_ATTRIBUTES=ATTRIBUTE

-- IMPORTANT:
-- - the alias names for the Foreign keys must be the same as in the inventory.
-- - the alias name for context code must be RES_CONTEXT_CODE
-- - NO ALIASES for atributes fields.

select 'Country' RES_SEARCH
,(SELECT meaning
	FROM fusion.fnd_lookups
	WHERE lookup_type = 'JEES_EURO_COUNTRY_CODES'
	AND lookup_code   = loc.country
	) RES_NAME
, remitToLocs.location_id RES_SITE_NUMBER
, hz_format_pub.format_address(loc.location_id,NULL,NULL,',',NULL,NULL,NULL,NULL) RES_ADDRESS
,(SELECT SET_NAME
	FROM fusion.FND_SETID_SETS_VL
	WHERE SET_ID = remitToLocs.SET_ID
	) RES_REMIT_TO_ADDRESS_SET
,NVL((SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  FlexfieldDataEO.country
	)
	,(SELECT meaning
	FROM fusion.fnd_lookup_values
	WHERE lookup_type = 'REMIT'
	AND LANGUAGE = USERENV('LANG')
	AND lookup_code   = FlexfieldDataEO.COUNTRY
	)) RES_COUNTRY
,FlexfieldDataEO.STATE RES_STATE
,FlexfieldDataEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,FlexfieldDataEO.ATTRIBUTE1
,FlexfieldDataEO.ATTRIBUTE2
,FlexfieldDataEO.ATTRIBUTE3
,FlexfieldDataEO.ATTRIBUTE4
,FlexfieldDataEO.ATTRIBUTE5
,FlexfieldDataEO.ATTRIBUTE6
,FlexfieldDataEO.ATTRIBUTE7
,FlexfieldDataEO.ATTRIBUTE8
,FlexfieldDataEO.ATTRIBUTE9
,FlexfieldDataEO.ATTRIBUTE10
,FlexfieldDataEO.ATTRIBUTE11
,FlexfieldDataEO.ATTRIBUTE12
,FlexfieldDataEO.ATTRIBUTE13
,FlexfieldDataEO.ATTRIBUTE14
,FlexfieldDataEO.ATTRIBUTE15
,FlexfieldDataEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,FlexfieldDataEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,FlexfieldDataEO.CREATED_BY  RSC_CREATED_BY
,FlexfieldDataEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,FlexfieldDataEO.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM RA_REMIT_TOS_ALL FlexfieldDataEO 
,ar_remit_to_locs_all remitToLocs
,hz_locations loc
,FND_SETID_SETS_VL
where (FlexfieldDataEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
FlexfieldDataEO.ATTRIBUTE1 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE2 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE3 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE4 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE5 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE6 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE7 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE8 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE9 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE10 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE11 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE12 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE13 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE14 IS NOT NULL OR 
FlexfieldDataEO.ATTRIBUTE15 IS NOT NULL
)
AND FND_SETID_SETS_VL.SET_ID = FlexfieldDataEO.SET_ID 
AND remitToLocs.location_id          = loc.location_id
AND FlexfieldDataEO.ADDRESS_LOC_SEQ_ID = remitToLocs.address_loc_seq_id
AND FlexfieldDataEO.COUNTRY             IS NOT NULL
ORDER BY 2,3,4