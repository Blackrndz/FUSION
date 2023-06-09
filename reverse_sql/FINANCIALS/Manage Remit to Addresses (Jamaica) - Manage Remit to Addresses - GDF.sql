/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Accounts%20Rules%20-%20GDF.sql $:
* $Id: Manage Asset Categories - Accounts Rules - GDF.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

 -- syntax: GDF_CODE (Descriptive Flexfield name)
 -- GDF_LOGIC_TO_APPLY=JG_AR_REMIT_TO_LOCS
 -- GDF_ATTRIBUTES=GLOBAL_ATTRIBUTE,GLOBAL_ATTRIBUTE_NUMBER,GLOBAL_ATTRIBUTE_DATE
 -- IMPORTANT:
 -- - the alias names for the Foreign keys must be the same as in the inventory.
 -- - the alias name for context code must be RES_CONTEXT_CODE
 -- - NO ALIASES for attributes fields.

SELECT 'Country' RES_SEARCH
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  loc.country
	) AS RES_NAME
,remitToLocs.location_id AS RES_SITE_NUMBER
,(SELECT SET_NAME 
	FROM FND_SETID_SETS_VL 
	WHERE SET_ID = remitToLocs.SET_ID
	) AS RES_REMIT_TO_ADDRESS_SET 
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  loc.country
	) AS RES_COUNTRY
,remitToLocs.GLOBAL_ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,remitToLocs.GLOBAL_ATTRIBUTE1
,remitToLocs.GLOBAL_ATTRIBUTE2
,remitToLocs.GLOBAL_ATTRIBUTE3
,remitToLocs.GLOBAL_ATTRIBUTE4
,remitToLocs.GLOBAL_ATTRIBUTE5
,remitToLocs.GLOBAL_ATTRIBUTE6
,remitToLocs.GLOBAL_ATTRIBUTE7
,remitToLocs.GLOBAL_ATTRIBUTE8
,remitToLocs.GLOBAL_ATTRIBUTE9
,remitToLocs.GLOBAL_ATTRIBUTE10
,remitToLocs.GLOBAL_ATTRIBUTE11
,remitToLocs.GLOBAL_ATTRIBUTE12
,remitToLocs.GLOBAL_ATTRIBUTE13
,remitToLocs.GLOBAL_ATTRIBUTE14
,remitToLocs.GLOBAL_ATTRIBUTE15
,remitToLocs.GLOBAL_ATTRIBUTE16
,remitToLocs.GLOBAL_ATTRIBUTE17
,remitToLocs.GLOBAL_ATTRIBUTE18
,remitToLocs.GLOBAL_ATTRIBUTE19
,remitToLocs.GLOBAL_ATTRIBUTE20
,remitToLocs.GLOBAL_ATTRIBUTE_NUMBER1
,remitToLocs.GLOBAL_ATTRIBUTE_NUMBER2
,remitToLocs.GLOBAL_ATTRIBUTE_NUMBER3
,remitToLocs.GLOBAL_ATTRIBUTE_NUMBER4
,remitToLocs.GLOBAL_ATTRIBUTE_NUMBER5
,TO_CHAR(remitToLocs.GLOBAL_ATTRIBUTE_DATE1, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE1
,TO_CHAR(remitToLocs.GLOBAL_ATTRIBUTE_DATE2, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE2
,TO_CHAR(remitToLocs.GLOBAL_ATTRIBUTE_DATE3, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE3
,TO_CHAR(remitToLocs.GLOBAL_ATTRIBUTE_DATE4, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE4
,TO_CHAR(remitToLocs.GLOBAL_ATTRIBUTE_DATE5, 'DD-Mon-YYYY') GLOBAL_ATTRIBUTE_DATE5
,loc.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,loc.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,loc.CREATED_BY  RSC_CREATED_BY
,loc.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM ar_remit_to_locs_all remitToLocs
,hz_locations loc
WHERE remitToLocs.location_id = loc.location_id
AND loc.country  = 'JM'
AND (remitToLocs.GLOBAL_ATTRIBUTE_CATEGORY IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE1 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE2 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE3 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE4 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE5 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE6 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE7 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE8 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE9 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE10 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE11 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE12 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE13 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE14 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE15 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE16 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE17 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE18 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE19 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE20 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_NUMBER1 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_NUMBER2 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_NUMBER3 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_NUMBER4 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_NUMBER5 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_DATE1 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_DATE2 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_DATE3 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_DATE4 IS NOT NULL
	OR remitToLocs.GLOBAL_ATTRIBUTE_DATE5 IS NOT NULL)
order by 1,2