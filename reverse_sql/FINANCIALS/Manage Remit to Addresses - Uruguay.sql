 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Remit%20to%20Addresses%20-%20Uruguay.sql $:
 * $Id: Manage Remit to Addresses - Uruguay.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT 'Country' RES_SEARCH
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  loc.country
	) RES_NAME
,remitToLocs.LOCATION_ID RES_SITE_NUMBER
,HZ_FORMAT_PUB.FORMAT_ADDRESS(loc.LOCATION_ID,NULL,NULL,',',NULL,NULL,NULL,NULL) RES_ADDRESS
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = remitToLocs.SET_ID
	) RES_REMIT_TO_ADDRESS_SET
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  loc.country
	) RES_COUNTRY
,loc.ADDRESS1 RES_ADDRESS_LINE_1
,loc.ADDRESS2 RES_ADDRESS_LINE_2
,loc.ADDRESS3 RES_ADDRESS_LINE_3
,loc.CITY RES_CITY
,loc.PROVINCE RES_PROVINCE
,loc.POSTAL_CODE RES_POSTAL_CODE
,loc.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,loc.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,loc.CREATED_BY RSC_CREATED_BY
,loc.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_REMIT_TO_LOCS_ALL remitToLocs
,HZ_LOCATIONS loc
WHERE remitToLocs.LOCATION_ID = loc.LOCATION_ID
AND loc.COUNTRY = 'UY'
ORDER BY 1,2