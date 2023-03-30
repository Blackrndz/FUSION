/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Policies%20by%20Expense%20Category%20-%20Mileage.sql $:
 * $Id: Manage Policies by Expense Category - Mileage.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EXM_MILEAGE_POLICIES

SELECT xlaANAE0.NAME RES_NAME
,xlaANAE0.ANALYTICAL_CRITERION_CODE RES_SHORT_NAME
,xlaANAE0.DESCRIPTION RES_DESCRIPTION
,DECODE(xlaANAE0.ENABLED_FLAG,'Y','Active','Inactive') RES_STATUS


,xlaANAE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,xlaANAE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,xlaANAE0.CREATED_BY RSC_CREATED_BY
,xlaANAE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLA_ANALYTICAL_HDRS_VL xlaANAE0
WHERE BALANCING_FLAG = 'N'
ORDER BY xlaANAE0.NAME