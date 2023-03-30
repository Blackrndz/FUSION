/* ****************************************************************************
 * $Revision: 78875 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-27 14:11:47 +0700 (Mon, 27 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Benefit%20Plans%20-%20Eligibility%20Relationship%20Types.sql $:
 * $Id: Manage Benefit Plans - Eligibility Relationship Types.sql 78875 2022-06-27 07:11:47Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=BEN_PL_F
 
SELECT * 
FROM (SELECT benPlansE0.NAME RES_PLAN_NAME
	,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
	,benPlansE0.NAME RES_PLAN_OR_OPTION_NAME
	,'Plan' RES_PLAN_OR_OPTION_DESCRIPTION
    ,(SELECT MEANING
        FROM FND_LOOKUP_VALUES
        WHERE LANGUAGE = USERENV('LANG')
        AND LOOKUP_TYPE = 'BEN_GRP_RLSHP'
        AND LOOKUP_CODE = designationsE0.GRP_RLSHP_CD
        ) RES_GROUP_RELATIONSHIP
    ,(SELECT MEANING
         FROM FND_LOOKUP_VALUES
         WHERE LANGUAGE = USERENV('LANG')
         AND LOOKUP_TYPE = 'BEN_DSGN_TYP'
         AND LOOKUP_CODE = designationsE0.DSGN_TYP_CD
         ) RES_DESIGNATION_TYPE
    ,(SELECT MEANING
        FROM FND_LOOKUP_VALUES
        WHERE LANGUAGE = USERENV('LANG')
        AND LOOKUP_TYPE = 'ORA_PER_CONTACT'
        AND LOOKUP_CODE = dsgnRelationshipsE0.RLSHP_TYP_CD
        ) RES_RELATIONSHIP_TYPE
	,dsgnRelationshipsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
	,dsgnRelationshipsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
	,dsgnRelationshipsE0.CREATED_BY  RSC_CREATED_BY
	,dsgnRelationshipsE0.CREATION_DATE  RSC_CREATION_DATE
	,null RSC_LEDGER_ID
	,null RSC_CHART_OF_ACCOUNTS_ID
	,null RSC_BUSINESS_UNIT_ID
	,null RSC_LEGAL_ENTITY_ID
	,null RSC_ORGANIZATION_ID
	,null RSC_BUSINESS_GROUP_ID
	,NULL RSC_ENTERPRISE_ID
	,benPlansE0.LEGISLATION_CODE RSC_COUNTRY_ID

    FROM BEN_PL_F benPlansE0
	,(SELECT NAME
		,PL_TYP_ID
		FROM BEN_PL_TYP_F
		WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		AND OPT_TYP_CD != 'FLXCR'
		) planTypesE0
    ,BEN_DSGN_RQMT_F designationsE0
    ,BEN_DSGN_RQMT_RLSHP_TYP dsgnRelationshipsE0
    WHERE SYSDATE BETWEEN benPlansE0.EFFECTIVE_START_DATE AND benPlansE0.EFFECTIVE_END_DATE
	AND benPlansE0.PL_TYP_ID = planTypesE0.PL_TYP_ID
	AND benPlansE0.PL_ID = designationsE0.PL_ID
    AND designationsE0.DSGN_RQMT_ID = dsgnRelationshipsE0.DSGN_RQMT_ID
    
    UNION
	
	SELECT benPlansE0.NAME RES_PLAN_NAME
	,TO_CHAR(benPlansE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
	,(SELECT NAME
         FROM BEN_OPT_F
         WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
         AND OPT_ID = planOptionsE0.OPT_ID
         ) RES_PLAN_OR_OPTION_NAME
	,'Options' RES_PLAN_OR_OPTION_DESCRIPTION
    ,(SELECT MEANING
        FROM FND_LOOKUP_VALUES
        WHERE LANGUAGE = USERENV('LANG')
        AND LOOKUP_TYPE = 'BEN_GRP_RLSHP'
        AND LOOKUP_CODE = designationsE0.GRP_RLSHP_CD
        ) RES_GROUP_RELATIONSHIP
    ,(SELECT MEANING
         FROM FND_LOOKUP_VALUES
         WHERE LANGUAGE = USERENV('LANG')
         AND LOOKUP_TYPE = 'BEN_DSGN_TYP'
         AND LOOKUP_CODE = designationsE0.DSGN_TYP_CD
         ) RES_DESIGNATION_TYPE
    ,(SELECT MEANING
        FROM FND_LOOKUP_VALUES
        WHERE LANGUAGE = USERENV('LANG')
        AND LOOKUP_TYPE = 'ORA_PER_CONTACT'
        AND LOOKUP_CODE = dsgnRelationshipsE0.RLSHP_TYP_CD
        ) RES_RELATIONSHIP_TYPE
	,dsgnRelationshipsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
	,dsgnRelationshipsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
	,dsgnRelationshipsE0.CREATED_BY  RSC_CREATED_BY
	,dsgnRelationshipsE0.CREATION_DATE  RSC_CREATION_DATE
	,null RSC_LEDGER_ID
	,null RSC_CHART_OF_ACCOUNTS_ID
	,null RSC_BUSINESS_UNIT_ID
	,null RSC_LEGAL_ENTITY_ID
	,null RSC_ORGANIZATION_ID
	,null RSC_BUSINESS_GROUP_ID
	,NULL RSC_ENTERPRISE_ID
	,benPlansE0.LEGISLATION_CODE RSC_COUNTRY_ID

    FROM BEN_PL_F benPlansE0
    ,BEN_OIPL_F planOptionsE0
    ,BEN_DSGN_RQMT_F designationsE0
    ,BEN_DSGN_RQMT_RLSHP_TYP dsgnRelationshipsE0
    WHERE benPlansE0.PL_ID = planOptionsE0.PL_ID
    AND planOptionsE0.OIPL_ID = designationsE0.OIPL_ID
    AND designationsE0.DSGN_RQMT_ID = dsgnRelationshipsE0.DSGN_RQMT_ID
    )
    
ORDER BY RES_PLAN_NAME
,RES_PLAN_OR_OPTION_NAME