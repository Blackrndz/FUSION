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

SELECT colAgreementsE0.IDENTIFICATION_CODE RES_IDENTIFICATION_CODE
,colAgreementsE0.COLLECTIVE_AGREEMENT_NAME RES_NAME
,colAgreementsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,colAgreementsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,colAgreementsE0.CREATED_BY RSC_CREATED_BY
,colAgreementsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,colAgreementsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM (SELECT IDENTIFICATION_CODE
	,COLLECTIVE_AGREEMENT_NAME
	,LEGISLATION_CODE
	,LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE
	,ROW_NUMBER() OVER(PARTITION BY IDENTIFICATION_CODE ORDER BY CREATION_DATE) R1
	FROM PER_COL_AGREEMENTS_F_VL 
	) colAgreementsE0
WHERE R1 = 1
ORDER BY colAgreementsE0.IDENTIFICATION_CODE
,colAgreementsE0.COLLECTIVE_AGREEMENT_NAME