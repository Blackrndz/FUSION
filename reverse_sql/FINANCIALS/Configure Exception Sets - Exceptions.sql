/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_SETS_ASSOCIATION
-- RSC_PREREQUISITE_OBJECTS=MSC_EXCEPTION_SETS_VL

SELECT ExceptionSetsE0.NAME RES_EXCEPTION_SET
,(SELECT ExGrpsE0.NAME
	FROM MSC_EXCEPTION_GROUP_ASSIGN ExGrpAssE0
	,MSC_EXCEPTION_GROUPS_TL ExGrpsE0
	WHERE ExGrpsE0.GROUP_ID = ExGrpAssE0.GROUP_ID
	AND ExGrpAssE0.EXCEPTION_ID = ExceptionsE0.EXCEPTION_ID
	AND ExGrpsE0.LANGUAGE = USERENV('LANG')
	) RES_PARENT_SELECTED_EXCEPTIONS
,ExceptionsE0.NAME RES_SELECTED_EXCEPTIONS
,ExceptionSetsAssE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ExceptionSetsAssE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ExceptionSetsAssE0.CREATED_BY RSC_CREATED_BY
,ExceptionSetsAssE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_EXCEPTION_SETS_VL ExceptionSetsE0
,MSC_EXCEPTION_SETS_ASSOCIATION ExceptionSetsAssE0
,MSC_EXCEPTION_VL ExceptionsE0
WHERE ExceptionSetsE0.EXCEPTION_SET_ID = ExceptionSetsAssE0.EXCEPTION_SET_ID 
AND ExceptionSetsAssE0.EXCEPTION_ID = ExceptionsE0.EXCEPTION_ID
ORDER BY 1,2,3