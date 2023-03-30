/* ****************************************************************************
* $Revision: 56748 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-07-20 11:24:21 +0700 (Wed, 20 Jul 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Banks%20-%20Banks.sql $:
* $Id: Manage Banks - Banks.sql 56748 2016-07-20 04:24:21Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT benGroupsE0.NAME RES_BENEFITS_GROUP_NAME
,benGroupsE0.BNG_DESC RES_BENEFITS_GROUP_DESCRIPTION
,(SELECT NAME
    FROM HR_ORGANIZATION_V
    WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
    AND CLASSIFICATION_CODE = 'HCM_LEMP'
    AND ORGANIZATION_ID = benGroupsE0.LEGAL_ENTITY_ID
     ) RES_LEGAL_EMPLOYER
,benGroupsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,benGroupsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,benGroupsE0.CREATED_BY RSC_CREATED_BY
,benGroupsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,benGroupsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM BEN_BENFTS_GRP benGroupsE0
ORDER BY benGroupsE0.NAME