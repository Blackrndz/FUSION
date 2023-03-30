/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Public%20Unique%20Identifier%20Profile%20Options%20-%20Profile%20Options.sql $:
 * $Id: Manage Public Unique Identifier Profile Options - Profile Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT DISTINCT PROFILEOPTIONEO.PROFILE_OPTION_NAME RES_PROFILE_OPTION_CODE
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME RES_PROFILE_DISPLAY_NAME
,ProfileOptionEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ProfileOptionEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ProfileOptionEO.CREATED_BY RSC_CREATED_BY
,ProfileOptionEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_PROFILE_OPTIONS_VL ProfileOptionEO
,FND_PROFILE_OPTION_VALUES ProfileOptionValueEO
,FND_PROFILE_HIERARCHIES PROFILEHIERARCHYEO
WHERE Profileoptioneo.Hierarchy_Name     = Profilehierarchyeo.Hierarchy_Name
AND PROFILEOPTIONEO.APPLICATION_ID       = 10054
AND PROFILEOPTIONEO.PROFILE_OPTION_NAME IN
	(SELECT BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_VALUE
	FROM ASK_BO_ATTRIBUTE_VALUES BOATTRIBUTEVALUESEO
	WHERE BOATTRIBUTEVALUESEO.BO_ATTRIBUTE_SHORT_NAME = 'profileOptionName'
	AND BoAttributeValuesEO.TASK_ID                  IN
		(SELECT task_id
		FROM ASK_TASKS_VL
		WHERE TASK_SHORT_NAME = 'ZCA_MANAGE_PUBLIC_UNIQUE_IDENTIFIER_PROFILE_OPTIONS'
		)
	)
AND ProfileOptionEO.APPLICATION_ID    = ProfileOptionValueEO.APPLICATION_ID(+)
AND Profileoptioneo.Profile_Option_Id = Profileoptionvalueeo.Profile_Option_Id(+)
ORDER BY PROFILEOPTIONEO.PROFILE_OPTION_NAME
,PROFILEOPTIONEO.USER_PROFILE_OPTION_NAME