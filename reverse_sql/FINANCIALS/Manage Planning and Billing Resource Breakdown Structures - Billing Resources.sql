/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


WITH FORMATE0 AS (SELECT RES_FORMAT_ID
	,NAME
	,(CASE 
		WHEN formatsE0.FORMAT_LEVEL != 1 THEN
			(SELECT NAME
				FROM PJF_RES_FORMATS_VL
				WHERE FORMAT_TOKEN = SUBSTR(formatsE0.FORMAT_TOKEN,1,3))
		END) PARENT1
	,(CASE 
		WHEN formatsE0.FORMAT_LEVEL != 2 THEN
			(SELECT NAME
				FROM PJF_RES_FORMATS_VL
				WHERE FORMAT_TOKEN = SUBSTR(formatsE0.FORMAT_TOKEN,5,3))
		END) PARENT2
	,(CASE 
		WHEN formatsE0.FORMAT_LEVEL != 3 THEN
			(SELECT NAME
				FROM PJF_RES_FORMATS_VL
				WHERE FORMAT_TOKEN = SUBSTR(formatsE0.FORMAT_TOKEN,9,3))
		END) PARENT3
	,(CASE 
		WHEN formatsE0.FORMAT_LEVEL != 4 THEN
			(SELECT NAME
				FROM PJF_RES_FORMATS_VL
				WHERE FORMAT_TOKEN = SUBSTR(formatsE0.FORMAT_TOKEN,13,3))
		END) PARENT4
	,SUBSTR(formatsE0.FORMAT_TOKEN,1,3) CODE1
	,SUBSTR(formatsE0.FORMAT_TOKEN,5,3) CODE2
	,SUBSTR(formatsE0.FORMAT_TOKEN,9,3) CODE3
	,SUBSTR(formatsE0.FORMAT_TOKEN,13,3) CODE4
	,SUBSTR(formatsE0.FORMAT_TOKEN,17,3) CODE5
	,(SELECT NAME
		FROM PJF_RES_FORMATS_VL
		WHERE FORMAT_TOKEN = SUBSTR(formatsE0.FORMAT_TOKEN,LENGTH(formatsE0.FORMAT_TOKEN)-2,3)
		) RES_FORMAT
	FROM PJF_RES_FORMATS_VL formatsE0
	)

SELECT resourcesE0.NAME RES_NAME
,PARENT1 RES_PARENT_RESOURCE_FORMAT_1
,PARENT2 RES_PARENT_RESOURCE_FORMAT_2
,PARENT3 RES_PARENT_RESOURCE_FORMAT_3
,PARENT4 RES_PARENT_RESOURCE_FORMAT_4
,RES_FORMAT RES_RESOURCE_FORMAT
,resPlansE0.ALIAS RES_NAME_RESOURCES
,(CASE
	WHEN CODE1 = 'ITM' THEN --Inventory Item
		TO_CHAR(resPlansE0.INVENTORY_ITEM_ID)
	WHEN CODE1 = 'ITC' THEN --Item Category
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = resPlansE0.ITEM_CATEGORY_ID)
	WHEN CODE1 = 'ORG' THEN --Organization
		(SELECT NAME
			FROM HR_ORGANIZATION_UNITS
			WHERE ORGANIZATION_ID = resPlansE0.ORGANIZATION_ID)
	WHEN CODE1 = 'PTP' THEN --System Person Type
		(SELECT USER_PERSON_TYPE
			FROM PER_PERSON_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND PERSON_TYPE_ID = resPlansE0.PERSON_TYPE_ID)
	WHEN CODE1 = 'NLR' THEN --Project Nonlabor Resource
		(SELECT NLR_NAME
			FROM PJF_NON_LABOR_RES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND NON_LABOR_RESOURCE_ID = resPlansE0.NON_LABOR_RESOURCE_ID)
	WHEN CODE1 = 'RES' THEN --Resource Class
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	WHEN CODE1 = 'JOB' THEN --Job
		(SELECT NAME
			FROM PER_JOBS_F_TL
			WHERE LANGUAGE = USERENV('LANG')			
			AND JOB_ID = resPlansE0.JOB_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE1 = 'PER' THEN --Named Person
		(SELECT FULL_NAME
			FROM PER_PERSON_NAMES_F
			WHERE PERSON_ID = resPlansE0.PERSON_ID
			AND NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE1 = 'EVT' THEN --Event Type
		(SELECT EVENT_TYPE_NAME
			FROM PJF_EVENT_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EVENT_TYPE_ID = resPlansE0.EVENT_TYPE_ID)
	WHEN CODE1 = 'EXC' THEN --Expenditure Category
		(SELECT EXPENDITURE_CATEGORY_NAME 
			FROM PJF_EXP_CATEGORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_CATEGORY_ID = resPlansE0.EXPENDITURE_CATEGORY_ID)
	WHEN CODE1 = 'EXT' THEN --Expenditure Type
		(SELECT EXPENDITURE_TYPE_NAME
			FROM PJF_EXP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_TYPE_ID = resPlansE0.EXPENDITURE_TYPE_ID)
	WHEN CODE1 = 'RVC' THEN --Revenue Category
		(SELECT lookup.MEANING
			FROM PJF_RBS_ELEMENT_MAP res
			,FND_LOOKUPS lookup
			WHERE res.RESOURCE_NAME = lookup.LOOKUP_CODE
			AND lookup.LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
			AND res.RESOURCE_ID = resPlansE0.REVENUE_CATEGORY_ID)
	WHEN CODE1 = 'SUP' THEN --Supplier
		(SELECT PARTY_NAME 
			FROM POZ_SUPPLIERS supsE0
			,HZ_PARTIES pty
			WHERE supsE0.PARTY_ID = pty.PARTY_ID
			AND VENDOR_ID = resPlansE0.VENDOR_ID)
	END) RES_RESOURCE_COMBINATION_1
,(CASE
	WHEN CODE2 = 'ITM' THEN --Inventory Item
		TO_CHAR(resPlansE0.INVENTORY_ITEM_ID)
	WHEN CODE2 = 'ITC' THEN --Item Category
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = resPlansE0.ITEM_CATEGORY_ID)
	WHEN CODE2 = 'ORG' THEN --Organization
		(SELECT NAME
			FROM HR_ORGANIZATION_UNITS
			WHERE ORGANIZATION_ID = resPlansE0.ORGANIZATION_ID)
	WHEN CODE2 = 'PTP' THEN --System Person Type
		(SELECT USER_PERSON_TYPE
			FROM PER_PERSON_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND PERSON_TYPE_ID = resPlansE0.PERSON_TYPE_ID)
	WHEN CODE2 = 'NLR' THEN --Project Nonlabor Resource
		(SELECT NLR_NAME
			FROM PJF_NON_LABOR_RES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND NON_LABOR_RESOURCE_ID = resPlansE0.NON_LABOR_RESOURCE_ID)
	WHEN CODE2 = 'RES' THEN --Resource Class
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	WHEN CODE2 = 'JOB' THEN --Job
		(SELECT NAME
			FROM PER_JOBS_F_TL
			WHERE LANGUAGE = USERENV('LANG')			
			AND JOB_ID = resPlansE0.JOB_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE2 = 'PER' THEN --Named Person
		(SELECT FULL_NAME
			FROM PER_PERSON_NAMES_F
			WHERE PERSON_ID = resPlansE0.PERSON_ID
			AND NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE2 = 'EVT' THEN --Event Type
		(SELECT EVENT_TYPE_NAME
			FROM PJF_EVENT_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EVENT_TYPE_ID = resPlansE0.EVENT_TYPE_ID)
	WHEN CODE2 = 'EXC' THEN --Expenditure Category
		(SELECT EXPENDITURE_CATEGORY_NAME 
			FROM PJF_EXP_CATEGORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_CATEGORY_ID = resPlansE0.EXPENDITURE_CATEGORY_ID)
	WHEN CODE2 = 'EXT' THEN --Expenditure Type
		(SELECT EXPENDITURE_TYPE_NAME
			FROM PJF_EXP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_TYPE_ID = resPlansE0.EXPENDITURE_TYPE_ID)
	WHEN CODE2 = 'RVC' THEN --Revenue Category
		(SELECT lookup.MEANING
			FROM PJF_RBS_ELEMENT_MAP res
			,FND_LOOKUPS lookup
			WHERE res.RESOURCE_NAME = lookup.LOOKUP_CODE
			AND lookup.LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
			AND res.RESOURCE_ID = resPlansE0.REVENUE_CATEGORY_ID)
	WHEN CODE2 = 'SUP' THEN --Supplier
		(SELECT PARTY_NAME 
			FROM POZ_SUPPLIERS supsE0
			,HZ_PARTIES pty
			WHERE supsE0.PARTY_ID = pty.PARTY_ID
			AND VENDOR_ID = resPlansE0.VENDOR_ID)
	END) RES_RESOURCE_COMBINATION_2
,(CASE
	WHEN CODE3 = 'ITM' THEN --Inventory Item
		TO_CHAR(resPlansE0.INVENTORY_ITEM_ID)
	WHEN CODE3 = 'ITC' THEN --Item Category
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = resPlansE0.ITEM_CATEGORY_ID)
	WHEN CODE3 = 'ORG' THEN --Organization
		(SELECT NAME
			FROM HR_ORGANIZATION_UNITS
			WHERE ORGANIZATION_ID = resPlansE0.ORGANIZATION_ID)
	WHEN CODE3 = 'PTP' THEN --System Person Type
		(SELECT USER_PERSON_TYPE
			FROM PER_PERSON_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND PERSON_TYPE_ID = resPlansE0.PERSON_TYPE_ID)
	WHEN CODE3 = 'NLR' THEN --Project Nonlabor Resource
		(SELECT NLR_NAME
			FROM PJF_NON_LABOR_RES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND NON_LABOR_RESOURCE_ID = resPlansE0.NON_LABOR_RESOURCE_ID)
	WHEN CODE3 = 'RES' THEN --Resource Class
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	WHEN CODE3 = 'JOB' THEN --Job
		(SELECT NAME
			FROM PER_JOBS_F_TL
			WHERE LANGUAGE = USERENV('LANG')			
			AND JOB_ID = resPlansE0.JOB_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE3 = 'PER' THEN --Named Person
		(SELECT FULL_NAME
			FROM PER_PERSON_NAMES_F
			WHERE PERSON_ID = resPlansE0.PERSON_ID
			AND NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE3 = 'EVT' THEN --Event Type
		(SELECT EVENT_TYPE_NAME
			FROM PJF_EVENT_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EVENT_TYPE_ID = resPlansE0.EVENT_TYPE_ID)
	WHEN CODE3 = 'EXC' THEN --Expenditure Category
		(SELECT EXPENDITURE_CATEGORY_NAME 
			FROM PJF_EXP_CATEGORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_CATEGORY_ID = resPlansE0.EXPENDITURE_CATEGORY_ID)
	WHEN CODE3 = 'EXT' THEN --Expenditure Type
		(SELECT EXPENDITURE_TYPE_NAME
			FROM PJF_EXP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_TYPE_ID = resPlansE0.EXPENDITURE_TYPE_ID)
	WHEN CODE3 = 'RVC' THEN --Revenue Category
		(SELECT lookup.MEANING
			FROM PJF_RBS_ELEMENT_MAP res
			,FND_LOOKUPS lookup
			WHERE res.RESOURCE_NAME = lookup.LOOKUP_CODE
			AND lookup.LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
			AND res.RESOURCE_ID = resPlansE0.REVENUE_CATEGORY_ID)
	WHEN CODE3 = 'SUP' THEN --Supplier
		(SELECT PARTY_NAME 
			FROM POZ_SUPPLIERS supsE0
			,HZ_PARTIES pty
			WHERE supsE0.PARTY_ID = pty.PARTY_ID
			AND VENDOR_ID = resPlansE0.VENDOR_ID)
	END) RES_RESOURCE_COMBINATION_3
,(CASE
	WHEN CODE4 = 'ITM' THEN --Inventory Item
		TO_CHAR(resPlansE0.INVENTORY_ITEM_ID)
	WHEN CODE4 = 'ITC' THEN --Item Category
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = resPlansE0.ITEM_CATEGORY_ID)
	WHEN CODE4 = 'ORG' THEN --Organization
		(SELECT NAME
			FROM HR_ORGANIZATION_UNITS
			WHERE ORGANIZATION_ID = resPlansE0.ORGANIZATION_ID)
	WHEN CODE4 = 'PTP' THEN --System Person Type
		(SELECT USER_PERSON_TYPE
			FROM PER_PERSON_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND PERSON_TYPE_ID = resPlansE0.PERSON_TYPE_ID)
	WHEN CODE4 = 'NLR' THEN --Project Nonlabor Resource
		(SELECT NLR_NAME
			FROM PJF_NON_LABOR_RES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND NON_LABOR_RESOURCE_ID = resPlansE0.NON_LABOR_RESOURCE_ID)
	WHEN CODE4 = 'RES' THEN --Resource Class
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	WHEN CODE4 = 'JOB' THEN --Job
		(SELECT NAME
			FROM PER_JOBS_F_TL
			WHERE LANGUAGE = USERENV('LANG')			
			AND JOB_ID = resPlansE0.JOB_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE4 = 'PER' THEN --Named Person
		(SELECT FULL_NAME
			FROM PER_PERSON_NAMES_F
			WHERE PERSON_ID = resPlansE0.PERSON_ID
			AND NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE4 = 'EVT' THEN --Event Type
		(SELECT EVENT_TYPE_NAME
			FROM PJF_EVENT_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EVENT_TYPE_ID = resPlansE0.EVENT_TYPE_ID)
	WHEN CODE4 = 'EXC' THEN --Expenditure Category
		(SELECT EXPENDITURE_CATEGORY_NAME 
			FROM PJF_EXP_CATEGORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_CATEGORY_ID = resPlansE0.EXPENDITURE_CATEGORY_ID)
	WHEN CODE4 = 'EXT' THEN --Expenditure Type
		(SELECT EXPENDITURE_TYPE_NAME
			FROM PJF_EXP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_TYPE_ID = resPlansE0.EXPENDITURE_TYPE_ID)
	WHEN CODE4 = 'RVC' THEN --Revenue Category
		(SELECT lookup.MEANING
			FROM PJF_RBS_ELEMENT_MAP res
			,FND_LOOKUPS lookup
			WHERE res.RESOURCE_NAME = lookup.LOOKUP_CODE
			AND lookup.LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
			AND res.RESOURCE_ID = resPlansE0.REVENUE_CATEGORY_ID)
	WHEN CODE4 = 'SUP' THEN --Supplier
		(SELECT PARTY_NAME 
			FROM POZ_SUPPLIERS supsE0
			,HZ_PARTIES pty
			WHERE supsE0.PARTY_ID = pty.PARTY_ID
			AND VENDOR_ID = resPlansE0.VENDOR_ID)
	END) RES_RESOURCE_COMBINATION_4
,(CASE
	WHEN CODE5 = 'ITM' THEN --Inventory Item
		TO_CHAR(resPlansE0.INVENTORY_ITEM_ID)
	WHEN CODE5 = 'ITC' THEN --Item Category
		(SELECT CATEGORY_NAME
			FROM EGP_CATEGORIES_VL
			WHERE CATEGORY_ID = resPlansE0.ITEM_CATEGORY_ID)
	WHEN CODE5 = 'ORG' THEN --Organization
		(SELECT NAME
			FROM HR_ORGANIZATION_UNITS
			WHERE ORGANIZATION_ID = resPlansE0.ORGANIZATION_ID)
	WHEN CODE5 = 'PTP' THEN --System Person Type
		(SELECT USER_PERSON_TYPE
			FROM PER_PERSON_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND PERSON_TYPE_ID = resPlansE0.PERSON_TYPE_ID)
	WHEN CODE5 = 'NLR' THEN --Project Nonlabor Resource
		(SELECT NLR_NAME
			FROM PJF_NON_LABOR_RES_TL
			WHERE LANGUAGE = USERENV('LANG')		
			AND NON_LABOR_RESOURCE_ID = resPlansE0.NON_LABOR_RESOURCE_ID)
	WHEN CODE5 = 'RES' THEN --Resource Class
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	WHEN CODE5 = 'JOB' THEN --Job
		(SELECT NAME
			FROM PER_JOBS_F_TL
			WHERE LANGUAGE = USERENV('LANG')			
			AND JOB_ID = resPlansE0.JOB_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE5 = 'PER' THEN --Named Person
		(SELECT FULL_NAME
			FROM PER_PERSON_NAMES_F
			WHERE PERSON_ID = resPlansE0.PERSON_ID
			AND NAME_TYPE = 'GLOBAL'
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN CODE5 = 'EVT' THEN --Event Type
		(SELECT EVENT_TYPE_NAME
			FROM PJF_EVENT_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EVENT_TYPE_ID = resPlansE0.EVENT_TYPE_ID)
	WHEN CODE5 = 'EXC' THEN --Expenditure Category
		(SELECT EXPENDITURE_CATEGORY_NAME 
			FROM PJF_EXP_CATEGORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_CATEGORY_ID = resPlansE0.EXPENDITURE_CATEGORY_ID)
	WHEN CODE5 = 'EXT' THEN --Expenditure Type
		(SELECT EXPENDITURE_TYPE_NAME
			FROM PJF_EXP_TYPES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND EXPENDITURE_TYPE_ID = resPlansE0.EXPENDITURE_TYPE_ID)
	WHEN CODE5 = 'RVC' THEN --Revenue Category
		(SELECT lookup.MEANING
			FROM PJF_RBS_ELEMENT_MAP res
			,FND_LOOKUPS lookup
			WHERE res.RESOURCE_NAME = lookup.LOOKUP_CODE
			AND lookup.LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
			AND res.RESOURCE_ID = resPlansE0.REVENUE_CATEGORY_ID)
	WHEN CODE5 = 'SUP' THEN --Supplier
		(SELECT PARTY_NAME 
			FROM POZ_SUPPLIERS supsE0
			,HZ_PARTIES pty
			WHERE supsE0.PARTY_ID = pty.PARTY_ID
			AND VENDOR_ID = resPlansE0.VENDOR_ID)
	END) RES_RESOURCE_COMBINATION_5
,(CASE
	WHEN CODE1 != 'RES' THEN
		(SELECT NAME
			FROM PJF_RESOURCE_CLASSES_VL
			WHERE RESOURCE_CLASS_CODE = resPlansE0.RESOURCE_CLASS_CODE)
	END) RES_RESOURCE_CLASS
,(SELECT NAME 
	FROM PJO_SPREAD_CURVES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SPREAD_CURVE_ID = resPlansE0.SPREAD_CURVE_ID
	) RES_SPREAD_CURVE
,DECODE(resPlansE0.ENABLED_FLAG,'N','Yes','No') RES_DISABLED
,resPlansE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,resPlansE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,resPlansE0.CREATED_BY RSC_CREATED_BY
,resPlansE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,resourcesE0.PROJECT_UNIT_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RBS_HEADERS_VL resourcesE0
,PJF_RBS_VERSIONS_B resVersionsE0
,PJF_PLAN_RBS_FORMATS planResFormatsE0
,FORMATE0 resFormatsE0
,PJF_RBS_ELEMENTS resPlansE0
WHERE resourcesE0.RBS_TYPE = 'BILLING'
AND resourcesE0.PROJECT_ID IS NULL
AND resourcesE0.RBS_HEADER_ID = resVersionsE0.RBS_HEADER_ID
AND resVersionsE0.RBS_VERSION_ID = planResFormatsE0.RBS_VERSION_ID
AND planResFormatsE0.RES_FORMAT_ID = resFormatsE0.RES_FORMAT_ID
AND resVersionsE0.RBS_VERSION_ID = resPlansE0.RBS_VERSION_ID
AND resFormatsE0.RES_FORMAT_ID = resPlansE0.RES_FORMAT_ID
ORDER BY resourcesE0.NAME
,(CASE	
	WHEN PARENT1 IS NULL THEN '1'
	ELSE PARENT1 END)
,(CASE	
	WHEN PARENT2 IS NULL THEN '1'
	ELSE PARENT2 END)
,(CASE	
	WHEN PARENT3 IS NULL THEN '1'
	ELSE PARENT3 END)
,(CASE	
	WHEN PARENT4 IS NULL THEN '1'
	ELSE PARENT4 END)
,RES_FORMAT
,resPlansE0.ALIAS