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
,TerritoriesE0.TERRITORY_SHORT_NAME RES_NAME
,remitToLocs.location_id RES_SITE_NUMBER
,hz_format_pub.format_address(loc.location_id,NULL,NULL,',',NULL,NULL,NULL,NULL) RES_ADDRESS
,(SELECT SET_NAME
	FROM fusion.FND_SETID_SETS_VL
	WHERE SET_ID = remitToLocs.SET_ID
	) RES_REMIT_TO_ADDRESS_SET
,TerritoriesE0.TERRITORY_SHORT_NAME RES_COUNTRY
,loc.address1 RES_ADDRESS_LINE_1
,loc.address2 RES_ADDRESS_LINE_2
,loc.address3 RES_ADDRESS_LINE_3
,loc.city RES_CITY
,loc.state RES_STATE
,loc.postal_code RES_POSTAL_CODE
,TimeZoneE0.NAME RES_TIME_ZONE
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

FROM ar_remit_to_locs_all remitToLocs
,hz_locations loc
,FND_TIMEZONES_VL TimeZoneE0
,FND_TERRITORIES_VL TerritoriesE0
WHERE remitToLocs.location_id = loc.location_id
AND loc.TIMEZONE_CODE         = TimeZoneE0.TIMEZONE_CODE
AND loc.country               = TerritoriesE0.TERRITORY_CODE
AND loc.country               = 'VN'
ORDER BY 1,2