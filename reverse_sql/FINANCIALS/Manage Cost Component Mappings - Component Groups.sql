/* ****************************************************************************
 * $Revision: 54470 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-19 10:52:05 +0700 (Tue, 19 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Contact Point Lookups - Lookup Codes.sql 54470 2016-04-19 03:52:05Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ComponentGroupEO.COMPONENT_GROUP_CODE RES_CODE
,ComponentGroupEO.NAME RES_NAME
,SetIdSetPEO.SET_NAME RES_SET_NAME
,ComponentGroupEO.DESCRIPTION RES_DESCRIPTION
,ComponentGroupEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ComponentGroupEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ComponentGroupEO.CREATED_BY RSC_CREATED_BY
,ComponentGroupEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CST_COMPONENT_GROUPS_VL ComponentGroupEO
,FND_SETID_SETS_VL SetIdSetPEO
WHERE ComponentGroupEO.SET_ID = SetIdSetPEO.SET_ID
ORDER BY SetIdSetPEO.SET_CODE
,ComponentGroupEO.COMPONENT_GROUP_CODE