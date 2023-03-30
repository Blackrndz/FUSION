/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Distribution%20Sets%20-%20Distribution%20Sets.sql $:
 * $Id: Manage Receivables Distribution Sets - Distribution Sets.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,ArDistributionSetsAll.DISTRIBUTION_SET_NAME RES_NAME
,ARDISTRIBUTIONSETSALL.DESCRIPTION RES_DESCRIPTION
,DECODE(ARDISTRIBUTIONSETSALL.STATUS,'A','Yes','No') RES_ACTIVE
,ARDISTRIBUTIONSETSALL.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ARDISTRIBUTIONSETSALL.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ARDISTRIBUTIONSETSALL.CREATED_BY  RSC_CREATED_BY
,ARDISTRIBUTIONSETSALL.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from AR_DISTRIBUTION_SETS_ALL ARDISTRIBUTIONSETSALL
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
where ARDISTRIBUTIONSETSALL.ORG_ID   = BUSINESSUNITPEO.BU_ID
ORDER BY BUSINESSUNITPEO.BU_NAME
,ArDistributionSetsAll.DISTRIBUTION_SET_NAME