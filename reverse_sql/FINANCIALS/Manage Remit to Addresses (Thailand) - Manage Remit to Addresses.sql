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
	)                                                                                AS RES_NAME
, remitToLocs.location_id                                                         AS RES_SITE_NUMBER
 ,hz_format_pub.format_address(loc.location_id, NULL, NULL, ',', NULL, NULL, NULL, NULL) AS RES_ADDRESS,
  (SELECT SET_NAME FROM fusion.FND_SETID_SETS_VL WHERE SET_ID = remitToLocs.SET_ID) AS RES_REMIT_TO_ADDRESS_SET ,
 (SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TERRITORY_CODE =  loc.country) AS RES_COUNTRY,
 loc.address1 AS RES_ADDRESS_LINE_1,
 loc.address2 AS RES_ADDRESS_LINE_2,
 loc.address2 AS RES_ADDRESS_LINE_3,
 loc.city AS RES_CITY,
 loc.state AS RES_STATE,
 loc.postal_code AS RES_POSTAL_CODE
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

FROM fusion.ar_remit_to_locs_all remitToLocs,
  fusion.hz_locations loc
WHERE remitToLocs.location_id = loc.location_id
AND loc.country  = 'TH'
order by 1,2
