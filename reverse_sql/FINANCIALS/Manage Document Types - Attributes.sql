/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Document%20Types%20-%20Attributes.sql $:
 * $Id: Manage Document Types - Attributes.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=HR_DOCUMENT_TYPES_VL
 
 SELECT (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	)  RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Document Name Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN DOCUMENT_NAME_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN DOCUMENT_NAME_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --DOCUMENT_NUMBER_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Document Number Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN DOCUMENT_NUMBER_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN DOCUMENT_NUMBER_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --DATE_FROM_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'From Date Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN DATE_FROM_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN DATE_FROM_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --DATE_TO_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'To Date Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN DATE_TO_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN DATE_TO_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --ISSUING_COUNTRY_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Issuing Country Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN ISSUING_COUNTRY_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN ISSUING_COUNTRY_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --ISSUING_LOCATION_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Issuing Location Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN ISSUING_LOCATION_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN ISSUING_LOCATION_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --ISSUING_AUTHORITY_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Issuing Authority Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN ISSUING_AUTHORITY_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN ISSUING_AUTHORITY_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --ISSUED_DATE_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Issued on Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN ISSUED_DATE_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN ISSUED_DATE_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO
 
 UNION
 
 --COMMENTS_REQUIRED
 
 SELECT  (SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_TYPE = 'ORA_PER_DOCUMENT_TYPE_LEVEL' 
	AND LOOKUP_CODE = hrDOCTYPEEO.DOCUMENT_TYPE_LEVEL
	AND LANGUAGE = USERENV('LANG') 
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
	) RES_DOCUMENT_TYPE_LEVEL
 ,hrDOCTYPEEO.DOCUMENT_TYPE RES_TYPE
 ,'Issuing Comments Applicable' RES_ATTRIBUTES_NAME
 ,(CASE WHEN COMMENTS_REQUIRED = 'N' THEN 
	'No'
	ELSE	
	'Yes' END)RES_RELEVANT
 ,(CASE WHEN COMMENTS_REQUIRED = 'R' THEN 
	'Yes'
	ELSE	
	'No' END)RES_REQUIRED
 
  ,hrDOCTYPEEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,hrDOCTYPEEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,hrDOCTYPEEO.CREATED_BY  RSC_CREATED_BY
  ,hrDOCTYPEEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,hrDOCTYPEEO.LEGISLATION_CODE RSC_COUNTRY_ID

  
 FROM HR_DOCUMENT_TYPES_VL hrDOCTYPEEO