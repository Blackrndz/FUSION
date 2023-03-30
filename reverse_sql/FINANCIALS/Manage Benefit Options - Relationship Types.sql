/* ****************************************************************************
* $Revision: 78759 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-06-15 12:41:43 +0700 (Wed, 15 Jun 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Options%20-%20Relationship%20Types.sql $:
* $Id: Manage Benefit Options - Relationship Types.sql 78759 2022-06-15 05:41:43Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT optionsE0.NAME RES_OPTION_NAME
,TO_CHAR(optionsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_GRP_RLSHP'
	AND LOOKUP_CODE = designeesE0.GRP_RLSHP_CD 
	) RES_GROUP_RELATIONSHIP
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_DSGN_TYP'
	AND LOOKUP_CODE = designeesE0.DSGN_TYP_CD 
	) RES_DESIGNATION_TYPE
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CONTACT'
	AND LOOKUP_CODE = designRelTypesE0.RLSHP_TYP_CD 
	) RES_RELATIONSHIP_TYPES
,designRelTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,designRelTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,designRelTypesE0.CREATED_BY RSC_CREATED_BY
,designRelTypesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,optionsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM BEN_OPT_F optionsE0
,BEN_DSGN_RQMT_F designeesE0
,BEN_DSGN_RQMT_RLSHP_TYP designRelTypesE0
WHERE optionsE0.OPT_ID = designeesE0.OPT_ID
AND designeesE0.DSGN_RQMT_ID = designRelTypesE0.DSGN_RQMT_ID
AND designeesE0.EFFECTIVE_START_DATE BETWEEN optionsE0.EFFECTIVE_START_DATE AND NVL(optionsE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
ORDER BY optionsE0.NAME
,optionsE0.EFFECTIVE_START_DATE