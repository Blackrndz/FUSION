 /* ****************************************************************************
 * $Revision: 79612 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-11-10 16:08:02 +0700 (Thu, 10 Nov 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Remit%20to%20Addresses%20-%20Receipt%20From%20Criteria.sql $:
 * $Id: Manage Remit to Addresses - Receipt From Criteria.sql 79612 2022-11-10 09:08:02Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT 'Country' RES_SEARCH
	,(SELECT TERRITORY_SHORT_NAME FROM fusion.FND_TERRITORIES_VL WHERE TERRITORY_CODE = loc.COUNTRY) AS RES_NAME
, remitToLocs.location_id                                                         AS RES_SITE_NUMBER
, hz_format_pub.format_address(loc.location_id,NULL,NULL,',',NULL,NULL,NULL,NULL) AS RES_ADDRESS
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
	))                                 AS RES_COUNTRY
, FlexfieldDataEO.STATE            AS RES_STATE
, FlexfieldDataEO.POSTAL_CODE_LOW  AS RES_FROM_POSTAL_CODE
, FlexfieldDataEO.POSTAL_CODE_HIGH AS RES_TO_POSTAL_CODE
, FlexfieldDataEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, FlexfieldDataEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, FlexfieldDataEO.CREATED_BY  RSC_CREATED_BY
, FlexfieldDataEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, FlexfieldDataEO.ORG_ID RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM fusion.ar_remit_to_locs_all remitToLocs
, fusion.hz_locations loc
, fusion.RA_REMIT_TOS_ALL FlexfieldDataEO
WHERE remitToLocs.location_id          = loc.location_id
AND FlexfieldDataEO.ADDRESS_LOC_SEQ_ID = remitToLocs.address_loc_seq_id
AND FlexfieldDataEO.COUNTRY             IS NOT NULL
--AND loc.country                        = 'US'
--AND FlexfieldDataEO.STATE             IS NOT NULL
ORDER BY 1,2