/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_ASSIGN_ATTR_LOOKUP'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'MANAGE_LRNR_ASSIGN_AS')
	) RES_ASSIGN_AS
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'MANAGE_LRNR_DUE_DATE_OFFSET'
	) RES_DUE_DATE
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'MANAGE_LRNR_NOTE'
	) RES_WITH_THIS_NOTE


-- Community Created Assignments Defaults

,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_AC_COMPL_CONFLICT_RULES'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'MANAGE_LRNR_COMMUNITY_COURSE_COMPL_ASSIGN_CONFLICT_RULE')
	) RES_COMMUNITY_CREATED_FOR_UNEX -- Community Created - For Unexpired Course Assignment in Completed or Bypass Completed Status Allow This Completion to Be Valid
,(SELECT DECODE(VALUE
		,'ASSIGN_NEW_AND_AUTO_COMPLETE','Create a new assignment and automatically mark it as completed'
		,'SKIP_CREATING_NEW_ASSIGNMENT','Skip creating a new assignment and leave existing completed assignments') 
	FROM WLF_PROPERTIES
	WHERE NAME = 'MANAGE_LRNR_COMMUNITY_SPEC_COMPL_ASSIGN_CONFLICT_RUL'
	) RES_COMMUNITY_CREATED_FOR_UN_0 -- Community Created - For Unexpired Specialization Assignment in Completed or Bypass Completed Status
,'Yes' RES_COMMUNITY_CREATED_FOR_EXIS -- Community Created - For Existing Assignment in Requested, Request Approved, Pending Active, Waitlisted, Pending Payment, Pending Prerequisites or Active Status
,'Yes' RES_COMMUNITY_CREATED_ALL_OTHE -- Community Created - All Other Existing Assignments in Not Passed, Withdrawn, Deleted and Request Rejected Status


-- Manager Created Assignments from Self-Service Defaults

,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_AC_COMPL_CONFLICT_RULES'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'MANAGE_LRNR_MNGR_COURSE_OFFERING_COMPL_ASSIGN_CONFLICT_RULE')
	) RES_MANAGER_CREATED_FOR_UNEXPI -- Manager Created - For Unexpired Course Assignment in Completed or Bypass Completed Status Allow This Completion to Be Valid
,(SELECT DECODE(VALUE
		,'ASSIGN_NEW_AND_AUTO_COMPLETE','Create a new assignment and automatically mark it as completed'
		,'SKIP_CREATING_NEW_ASSIGNMENT','Skip creating a new assignment and leave existing completed assignments') 
	FROM WLF_PROPERTIES
	WHERE NAME = 'MANAGE_LRNR_MNGR_SPEC_COMPL_ASSIGN_CONFLICT_RULE'
	) RES_MANAGER_CREATED_FOR_UNEX_1 -- Manager Created - For Unexpired Specialization Assignment in Completed or Bypass Completed Status
,'Yes' RES_MANAGER_CREATED_FOR_EXISTI -- Manager Created - For Existing Assignment in Requested, Request Approved, Pending Active, Waitlisted, Pending Payment, Pending Prerequisites or Active Status
,'Yes' RES_MANAGER_CREATED_ALL_OTHER_ -- Manager Created - All Other Existing Assignments in Not Passed, Withdrawn, Deleted and Request Rejected Status


,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'MANAGE_LRNR_DUE_DATE_OFFSET'
	) RES_ENABLE_LEARNER_SELECTION_B 
	-- Enable Learner Selection by Workforce Structure Hierarchy
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_LRNR_DEF_HIERARCHY'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'MANAGE_LRNR_HIERARCY_TYPE')
	) RES_HIERARCHY_TYPE
,(CASE
	WHEN (SELECT VALUE FROM WLF_PROPERTIES WHERE NAME = 'MANAGE_LRNR_HIERARCY_TYPE') = 'ORA_LRNR_DEF_SEARCH_ORG' THEN
		--ORGANIZATION
		(SELECT DISTINCT tree.TREE_NAME
			FROM FND_TREE_VL tree
			,FND_TREE_VERSION_VL ver
			WHERE tree.TREE_CODE = ver.TREE_CODE
			AND tree.TREE_STRUCTURE_CODE = ver.TREE_STRUCTURE_CODE
			AND ver.TREE_VERSION_ID = (SELECT VALUE
				FROM WLF_PROPERTIES
				WHERE NAME = 'MANAGE_LRNR_SELECTED_ORG_HIERARCHY'))
		
	ELSE
		 --DEPT
		(SELECT DISTINCT tree.TREE_NAME
			FROM FND_TREE_VL tree
			,FND_TREE_VERSION_VL ver
			WHERE tree.TREE_CODE = ver.TREE_CODE
			AND tree.TREE_STRUCTURE_CODE = ver.TREE_STRUCTURE_CODE
			AND ver.TREE_VERSION_ID = (SELECT VALUE
				FROM WLF_PROPERTIES
				WHERE NAME = 'MANAGE_LRNR_SELECTED_DEPT_HIERARCHY'))
		
	END) RES_HIERARCHY_NAME
,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE 
	,ROW_NUMBER() OVER (ORDER BY LAST_UPDATE_DATE DESC) R1
	FROM WLF_PROPERTIES 
	) setupsE0
WHERE R1 = 1