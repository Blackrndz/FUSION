/* ****************************************************************************
 * $Revision: 55017 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-06 17:03:01 +0700 (Fri, 06 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Standard%20Lookup%20Type.sql $:
 * $Id: Manage Contact Point Lookups - Standard Lookup Type.sql 55017 2016-05-06 10:03:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT CollectorEO.NAME 								RES_COLLECTOR_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'IEX_COLLECTOR_TYPE'
	AND LOOKUP_CODE   = CollectorEO.RESOURCE_TYPE
	) 													RES_TYPE
,DECODE(CollectorEO.RESOURCE_TYPE,'RS_EMPLOYEE',EmpNameE0.DISPLAY_NAME,'RS_RESOURCE',GroupNameE0.NAME)
														RES_EMPLOYEE_OR_GROUP
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'IEX_AGING_TYPE'
	AND LOOKUP_CODE   = CollectorEO.STATUS
	) 													RES_ENABLED
,TO_CHAR(CollectorEO.INACTIVE_DATE,'DD-Mon-YYYY') 		RES_INACTIVE_DATE
,(SELECT SET_NAME
	FROM FND_SETID_SETS_VL
	WHERE SET_ID = CollectorEO.SET_ID
	) 													RES_COLLECTOR_SET
,CollectorEO.LAST_UPDATED_BY 							RSC_LAST_UPDATED_BY
,CollectorEO.LAST_UPDATE_DATE 							RSC_LAST_UPDATE_DATE
,CollectorEO.CREATED_BY 								RSC_CREATED_BY
,CollectorEO.CREATION_DATE 								RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_COLLECTORS CollectorEO
,(SELECT people.PERSON_ID
	,names.DISPLAY_NAME
	,people.EFFECTIVE_END_DATE
	,people.EFFECTIVE_START_DATE
	,names.NAME_TYPE
	FROM PER_ALL_PEOPLE_F people
	,PER_PERSON_TYPE_USAGES_F usages
	,PER_PERSON_NAMES_F names
	WHERE people.PERSON_ID         = usages.PERSON_ID
	AND people.PERSON_ID           = names.PERSON_ID
	AND usages.SYSTEM_PERSON_TYPE IN('CWK','EMP')
	AND names.Name_TYPE            = 'GLOBAL'
	AND TRUNC(sysdate) BETWEEN people.EFFECTIVE_START_DATE AND people.EFFECTIVE_END_DATE
	) EmpNameE0
,(SELECT OrganizationDPEO.ORGANIZATION_ID
	,OrganizationDPEO.NAME
	FROM HR_ORGANIZATION_V OrganizationDPEO
	WHERE((OrganizationDPEO.CLASSIFICATION_CODE = 'COLLECTIONS_GROUP')
	AND(UPPER(OrganizationDPEO.STATUS)          = 'A'))
	) GroupNameE0
WHERE CollectorEO.EMPLOYEE_ID = EmpNameE0.PERSON_ID(+)
AND CollectorEO.RESOURCE_ID   = GroupNameE0.ORGANIZATION_ID(+)
ORDER BY CollectorEO.SET_ID
,CollectorEO.NAME