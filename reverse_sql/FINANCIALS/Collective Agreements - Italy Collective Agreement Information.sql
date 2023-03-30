/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PER_COL_AGREEMENTS_F_VL

SELECT TO_CHAR(colAgreementsE0.EFFECTIVE_START_DATE,'DD-MM-YYYY') RES_EFFECTIVE_START_DATE
,colAgreementsE0.IDENTIFICATION_CODE RES_IDENTIFICATION_CODE
,colAgreementsE0.COLLECTIVE_AGREEMENT_NAME RES_NAME
,'' RES_QUALIFICATION
,'' RES_LEVEL
,extrasE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,extrasE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,extrasE0.CREATED_BY RSC_CREATED_BY
,extrasE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,colAgreementsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PER_COL_AGREEMENTS_F_VL colAgreementsE0
,PER_COL_AGRS_EXTRA_INFO_F extrasE0
WHERE colAgreementsE0.EFFECTIVE_END_DATE BETWEEN extrasE0.EFFECTIVE_START_DATE AND extrasE0.EFFECTIVE_END_DATE
AND colAgreementsE0.COLLECTIVE_AGREEMENT_ID = extrasE0.COLLECTIVE_AGREEMENT_ID
ORDER BY colAgreementsE0.IDENTIFICATION_CODE
,colAgreementsE0.COLLECTIVE_AGREEMENT_NAME
,colAgreementsE0.EFFECTIVE_START_DATE
,extrasE0.SEQUENCE_NUMBER