/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Shipping Document Sequences - Assignment.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select QRSLT.SEQ_NAME RES_DOCUMENT_SEQUENCE_NAME
, QRSLT.CATEGORY_CODE RES_CATEGORY
, QRSLT.NAME RES_DOCUMENT_SEQUENCE_CATEGORY
, QRSLT.APPLICATION_NAME1 RES_APPLICATION
, QRSLT.TYPE_MEANING RES_METHOD
, TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
, TO_CHAR(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
, DECODE(QRSLT.DETERMINANT_TYPE, 'BU', QRSLT.Name1, 'LEDGER', QRSLT.LEDGERNAME1, 'LE', QRSLT.LEGALNAME, NULL) RES_VALUE 
, QRSLT.LEGAL_ENTITY_IDENTIFIER RES_LEGAL_ENTITY_IDENTIFIER
, QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, QRSLT.CREATED_BY  RSC_CREATED_BY
, QRSLT.CREATION_DATE  RSC_CREATION_DATE
, (CASE
	WHEN QRSLT.DETERMINANT_TYPE = 'LEDGER' THEN
		QRSLT.DETERMINANT_VALUE
	ELSE
		NULL
	END) RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, (CASE
	WHEN QRSLT.DETERMINANT_TYPE = 'BU' THEN
		QRSLT.DETERMINANT_VALUE
	ELSE
		NULL
	END) RSC_BUSINESS_UNIT_ID
, (CASE
	WHEN QRSLT.DETERMINANT_TYPE = 'LE' THEN
		QRSLT.DETERMINANT_VALUE
	ELSE
		NULL
	END) RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM
	(SELECT DOCUMENTSEQUENCESEO.DETERMINANT_TYPE
	,(SELECT MEANING
		FROM FND_LOOKUP_VALUES
		WHERE LOOKUP_type = 'FND_DOCUMENT_SEQUENCES_TYPE'
		AND lookup_code   = DocSequenceAssignmentsEO.METHOD_CODE
		AND ENABLED_FLAG = 'Y'
	    AND LANGUAGE = USERENV('LANG')
		) TYPE_MEANING
	,DocSequenceAssignmentsEO.START_DATE
	,DocSequenceAssignmentsEO.END_DATE
	,DocSequenceAssignmentsEO.DETERMINANT_VALUE
	,DocSequenceAssignmentsEO.LAST_UPDATE_DATE
	,DocSequenceAssignmentsEO.LAST_UPDATED_BY	
	,DocSequenceAssignmentsEO.CREATION_DATE
	,DocSequenceAssignmentsEO.CREATED_BY	
	,DocSequenceAssignmentsEO.ENTERPRISE_ID	
	,DocSequenceAssignmentsEO.CATEGORY_CODE 
	,DocSequenceCategoriesPEO.NAME
	,DocSequenceCategoriesPEO.APPLICATION_ID AS APPLICATION_ID1
	,DocSequenceCategoriesPEO.CODE
	,DeterminantValueBUEO.NAME AS NAME1
	,DeterminantValueBUEO.ORGANIZATION_ID
	,DeterminantValueBUEO.EFFECTIVE_START_DATE
	,DeterminantValueBUEO.EFFECTIVE_END_DATE
	,DeterminantValueLedgerEO.NAME AS LEDGERNAME1
	,DeterminantValueLedgerEO.LEDGER_ID
	,DeterminantValueLegalEO.LEGAL_ENTITY_IDENTIFIER
	,DeterminantValueLegalEO.LEGAL_ENTITY_ID
	,APPLTAXONOMYPEO.USER_MODULE_NAME
	,ApplicationPEO.APPLICATION_NAME
	,ApplicationPE1.APPLICATION_NAME as APPLICATION_NAME1
	,DETERMINANTVALUELEGALEO.NAME AS LEGALNAME
	,DOCUMENTSEQUENCESEO.NAME     AS SEQ_NAME
	FROM FND_DOC_SEQUENCE_ASSIGNMENTS DocSequenceAssignmentsEO
	,FND_DOC_SEQUENCE_CATEGORIES DocSequenceCategoriesPEO
	,HR_ALL_ORGANIZATION_UNITS_F_VL DeterminantValueBUEO
	,GL_LEDGERS_PUBLIC_V DeterminantValueLedgerEO
	,XLE_FIRSTPARTY_INFORMATION_V DETERMINANTVALUELEGALEO
	,FND_DOCUMENT_SEQUENCES DOCUMENTSEQUENCESEO
	,FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO
	,FND_APPLICATION_VL ApplicationPEO
	,FND_APPLICATION_VL ApplicationPE1
	WHERE DOCUMENTSEQUENCESEO.MODULE_ID = APPLTAXONOMYPEO.MODULE_ID
	AND(DocumentSequencesEO.MODULE_ID  IN
		(SELECT rf.child_module_id
		FROM fnd_appl_taxonomy_rf rf
		,fnd_appl_taxonomy at
		WHERE at.module_type = 'APPLICATION'
		AND at.module_key    = 'WSH'
		AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID
		))
	AND DOCUMENTSEQUENCESEO.APPLICATION_ID = ApplicationPEO.APPLICATION_ID
	AND DocSequenceAssignmentsEO.APPLICATION_ID = ApplicationPE1.APPLICATION_ID
	AND DOCUMENTSEQUENCESEO.DOC_SEQUENCE_ID        = DocSequenceAssignmentsEO.DOC_SEQUENCE_ID
	AND DocSequenceAssignmentsEO.APPLICATION_ID    = DocSequenceCategoriesPEO.APPLICATION_ID
	and DOCSEQUENCEASSIGNMENTSEO.CATEGORY_CODE     = DOCSEQUENCECATEGORIESPEO.CODE	
	and DOCSEQUENCEASSIGNMENTSEO.DETERMINANT_VALUE = DETERMINANTVALUEBUEO.ORGANIZATION_ID(+)
	AND(sysdate BETWEEN DeterminantValueBUEO.EFFECTIVE_START_DATE(+) AND DeterminantValueBUEO.EFFECTIVE_END_DATE(+))
	AND DocSequenceAssignmentsEO.DETERMINANT_VALUE = DeterminantValueLedgerEO.LEDGER_ID(+)
	AND DOCSEQUENCEASSIGNMENTSEO.DETERMINANT_VALUE = DETERMINANTVALUELEGALEO.LEGAL_ENTITY_ID(+)
	) QRSLT
order by QRSLT.SEQ_NAME
,QRSLT.NAME