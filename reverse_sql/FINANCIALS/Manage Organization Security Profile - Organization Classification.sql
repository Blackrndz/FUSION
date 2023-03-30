/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT orgSecPflsE0.NAME RES_NAME
,(SELECT CLASSIFICATION_NAME
    FROM HR_ORG_CLASSIFICATIONS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND CLASSIFICATION_CODE = pflClassesE0.CLASSIFICATION_CD
    ) RES_CLASSIFICATION_NAME


,pflClassesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pflClassesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pflClassesE0.CREATED_BY RSC_CREATED_BY
,pflClassesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,orgSecPflsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_ORG_SECURITY_PROFILES orgSecPflsE0
,PER_ORG_SEC_PROFILE_CLASSES pflClassesE0
WHERE orgSecPflsE0.ORG_SECURITY_PROFILE_ID = pflClassesE0.ORG_SECURITY_PROFILE_ID
ORDER BY orgSecPflsE0.NAME