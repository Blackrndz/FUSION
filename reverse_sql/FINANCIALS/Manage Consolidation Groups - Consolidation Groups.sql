/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Consolidation%20Groups%20-%20Consolidation%20Groups.sql $:
 * $Id: Manage Consolidation Groups - Consolidation Groups.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=PAY_CONSOLIDATION_SETS
 

SELECT payCONSETEO.CONSOLIDATION_SET_NAME RES_NAME
,payCONSETEO.CONSOLIDATION_SET_CODE RES_CODE
,(SELECT NAME FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
	WHERE LEGISLATIVE_DATA_GROUP_ID = payCONSETEO.LEGISLATIVE_DATA_GROUP_ID) RES_LEGISLATIVE_DATA_GROUP
,payCONSETEO.COMMENTS RES_DESCRIPTION
,payCONSETEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payCONSETEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payCONSETEO.CREATED_BY RSC_CREATED_BY
,payCONSETEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_CONSOLIDATION_SETS payCONSETEO
ORDER BY 2