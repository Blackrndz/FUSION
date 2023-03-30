/* ****************************************************************************
* $Revision: 78693 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-07 17:22:14 +0700 (Tue, 07 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Templates%20-%20Business%20Unit%20Cross-Charge%20Transactions.sql $:
* $Id: Manage Project Templates - Business Unit Cross-Charge Transactions.sql 78693 2022-06-07 10:22:14Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT projTemplatesE0.NAME RES_TEMPLATE_NAME
,projTemplatesE0.SEGMENT1 RES_TEMPLATE_NUMBER
,(SELECT BU_NAME
    FROM FUN_ALL_BUSINESS_UNITS_V
    WHERE BU_ID = ccBU.BU_ID
    ) RES_PROVIDER_BUSINESS_UNIT
,ccBU.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ccBU.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ccBU.CREATED_BY  RSC_CREATED_BY
,ccBU.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,projTemplatesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_PROJECTS_ALL_VL projTemplatesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
,PJC_CC_PRJ_BU_RELATIONSHIPS ccBU
WHERE projTemplatesE0.TEMPLATE_FLAG = 'Y'
AND projTemplatesE0.ORG_ID = buE0.BU_ID
AND projTemplatesE0.PROJECT_ID = ccBU.PROJECT_ID
ORDER BY projTemplatesE0.NAME,2