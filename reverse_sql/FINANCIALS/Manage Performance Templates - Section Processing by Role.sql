/* ****************************************************************************
 * $Revision: 78329 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-04-19 15:19:57 +0700 (Tue, 19 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Performance%20Templates%20-%20Section%20Processing%20by%20Role.sql $:
 * $Id: Manage Performance Templates - Section Processing by Role.sql 78329 2022-04-19 08:19:57Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS = HRA_TMPL_SECTIONS
 -- RSC_PREREQUISITE_OBJECTS = HRA_TMPL_DEFNS_VL
 
SELECT pfTemplatesE0.NAME RES_NAME
,(SELECT NAME
    FROM HRA_SECTION_DEFNS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND SECTION_DEF_ID = tempSectionsE0.SECTION_DEF_ID
    ) RES_SECTION_NAME
,(SELECT DESCRIPTION
    FROM HRA_SECTION_DEFNS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND SECTION_DEF_ID = tempSectionsE0.SECTION_DEF_ID
    ) RES_SECTION_DESCRIPTION
,rolesE0.NAME RES_PROCESSING_BY_ROLE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRA_RATINGS_REQUIRED_TYPE'
    AND LOOKUP_CODE = sectionRolesE0.SECTION_COMMENTS_REQUIRED_CODE
     ) RES_SECTION_COMMENTS
,DECODE(sectionRolesE0.SHARE_COMMENTS_FLAG,'Y','Yes','No') RES_SHARE_COMMENTS	 

,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRA_RATINGS_REQUIRED_TYPE'
    AND LOOKUP_CODE = sectionRolesE0.ITEM_RATINGS_REQUIRED_CODE
     ) RES_ITEM_RATINGS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRA_RATINGS_REQUIRED_TYPE'
    AND LOOKUP_CODE = sectionRolesE0.ITEM_COMMENTS_REQUIRED_CODE
     ) RES_ITEM_COMMENTS
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'HRA_RATINGS_REQUIRED_TYPE'
    AND LOOKUP_CODE = sectionRolesE0.SECTION_RATINGS_REQUIRED_CODE
     ) RES_SECTION_RATINGS
,DECODE(sectionRolesE0.SHARE_RATINGS_FLAG,'Y','Yes','No') RES_SHARE_RATINGS
,DECODE(sectionRolesE0.UPDATE_PROFILE_FLAG,'Y','Yes','No') RES_UPDATE_PROFILE
,DECODE(sectionRolesE0.VIEW_PCPN_NAME_FLAG,'Y','Yes','No') RES_VIEW_PARTICIPANT_NAMES
,DECODE(sectionRolesE0.VIEW_PCPN_ROLE_FLAG,'Y','Yes','No') RES_VIEW_PARTICIPANT_ROLES
,(CASE WHEN sectionRolesE0.UPDATE_PROFILE_FLAG = 'Y' THEN
	(SELECT DESCRIPTION FROM HRT_QUALIFIERS_VL WHERE QUALIFIER_SET_ID = sectionRolesE0.QUALIFIER_SET_ID AND QUALIFIER_ID = sectionRolesE0.QUALIFIER_ID)
	ELSE NULL
	END)RES_INSTANCE_QUALIFIER

,sectionRolesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,sectionRolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,sectionRolesE0.CREATED_BY  RSC_CREATED_BY
,sectionRolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  

FROM HRA_TMPL_DEFNS_VL pfTemplatesE0
,HRA_TMPL_SECTIONS tempSectionsE0
,HRA_TMPL_ROLE_ACTIONS sectionRolesE0
,(SELECT tmplRolesE0.TMPL_ROLE_ID
    ,roleDefnsE0.NAME
    FROM HRA_TMPL_ROLES tmplRolesE0
    ,HRA_ROLE_DEFNS_VL roleDefnsE0
    WHERE tmplRolesE0.ROLE_ID = roleDefnsE0.ROLE_ID
    AND tmplRolesE0.ROLE_TYPE_CODE = roleDefnsE0.ROLE_TYPE_CODE
    ) rolesE0
WHERE pfTemplatesE0.TEMPLATE_DEFN_ID = tempSectionsE0.TEMPLATE_DEFN_ID
AND tempSectionsE0.SECTION_ID = sectionRolesE0.SECTION_ID
AND sectionRolesE0.TMPL_ROLE_ID = rolesE0.TMPL_ROLE_ID
ORDER BY pfTemplatesE0.NAME
,tempSectionsE0.SEQUENCE_NUMBER