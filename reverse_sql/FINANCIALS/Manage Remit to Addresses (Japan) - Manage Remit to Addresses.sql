 /* ****************************************************************************
 * $Revision: 79984 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2023-01-17 18:33:06 +0700 (Tue, 17 Jan 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Remit%20to%20Addresses%20(Japan)%20-%20Manage%20Remit%20to%20Addresses.sql $:
 * $Id: Manage Remit to Addresses (Japan) - Manage Remit to Addresses.sql 79984 2023-01-17 11:33:06Z tanawat.wongjan $:
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
 loc.postal_code AS RES_POSTAL_CODE,
 loc.state AS RES_PREFECTURE,
 loc.COUNTY RES_COUNTY,
 loc.city AS RES_CITY,
 loc.address1 AS RES_ADDRESS_LINE_1,
 loc.address2 AS RES_ADDRESS_LINE_2,
 loc.address3 AS RES_ADDRESS_LINE_3,
 loc.ADDRESS_LINES_PHONETIC AS RES_PHONETIC_ADDRESS,
 loc.ADDR_ELEMENT_ATTRIBUTE2  RES_WARD
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
AND loc.country  = 'JP'
order by 1,2
