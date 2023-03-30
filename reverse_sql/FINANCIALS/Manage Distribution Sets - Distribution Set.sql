/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Distribution%20Sets%20-%20Distribution%20Set.sql $:
 * $Id: Manage Distribution Sets - Distribution Set.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,ApDistributionSetsAll.DISTRIBUTION_SET_NAME RES_NAME
,ApDistributionSetsAll.DESCRIPTION RES_DESCRIPTION
,APDISTRIBUTIONSETSALL.TOTAL_PERCENT_DISTRIBUTION RES_DISTRIBUTION_PERCENTAGE
,to_char(ApDistributionSetsAll.INACTIVE_DATE,'DD-Mon-YYYY') RES_INACTIVE_DATE
,APDISTRIBUTIONSETSALL.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,APDISTRIBUTIONSETSALL.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,APDISTRIBUTIONSETSALL.CREATED_BY  RSC_CREATED_BY
,APDISTRIBUTIONSETSALL.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,APDISTRIBUTIONSETSALL.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from FUN_ALL_BUSINESS_UNITS_V BUSINESSUNITPEO
,AP_DISTRIBUTION_SETS_ALL APDISTRIBUTIONSETSALL
where BUSINESSUNITPEO.BU_ID = APDISTRIBUTIONSETSALL.ORG_ID
ORDER BY ApDistributionSetsAll.DISTRIBUTION_SET_NAME