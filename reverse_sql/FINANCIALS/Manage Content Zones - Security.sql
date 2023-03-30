/* ****************************************************************************
* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT (SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = contentZonesE0.PRC_BU_ID
	) RES_PROCUREMENT_BU
,contentZonesE0.CONTENT_ZONE_NAME RES_CONTENT_ZONE
,(SELECT LIST_NAME
	FROM PER_PERSON_NAMES_F
	WHERE PERSON_ID = contentZoneSecurityE0.WORKER_ID
	AND NAME_TYPE = 'GLOBAL'
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) RES_WORKER_NAME
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = contentZoneSecurityE0.REQ_BU_ID
	) RES_BUSINESS_UNIT
,contentZoneSecurityE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contentZoneSecurityE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contentZoneSecurityE0.CREATED_BY RSC_CREATED_BY
,contentZoneSecurityE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,contentZonesE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM POR_CONTENT_ZONES_ALL_VL contentZonesE0
,POR_CZ_SECURITY_ASSIGNMENTS contentZoneSecurityE0
WHERE contentZonesE0.CONTENT_ZONE_ID = contentZoneSecurityE0.CONTENT_ZONE_ID
ORDER BY 1,2,3,4