 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
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
,loc.STATE RES_STATE
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
AND loc.COUNTRY = 'NA'
ORDER BY 1,2