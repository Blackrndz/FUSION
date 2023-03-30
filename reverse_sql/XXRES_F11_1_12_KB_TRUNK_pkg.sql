create or replace PACKAGE XXRES_F11_1_12_KB_TRUNK_pkg AUTHID CURRENT_USER
IS
	rsc_package_version varchar2(50):='FUSION - 11.1.9 - TRUNK.$Revision: 58641 $:';
	
	FUNCTION get_rsc_package_version RETURN VARCHAR2;
  
    FUNCTION get_code_combination(p_code_combination_id number)
	RETURN VARCHAR2 DETERMINISTIC;
	
TYPE DFF_RECORD
IS
	RECORD
	(
		col_1           VARCHAR2(50),
		col_2           VARCHAR2(50),
		col_3           VARCHAR2(50),
		COL_4           VARCHAR2(50),
		COL_5           VARCHAR2(50),
		COL_6           VARCHAR2(50),
		COL_7           VARCHAR2(50),
		col_8           VARCHAR2(50),
		FIELD_NAME      VARCHAR2(50),
		FIELD_VALUE     VARCHAR2(250),
		SEQUENCE_NUMBER VARCHAR2(3)) ;
TYPE DFF_TABLE
IS
	TABLE OF DFF_RECORD;

FUNCTION GET_DFF(
		P_APPLICATION_ID IN NUMBER,
		P_DFF_CODE       IN VARCHAR2,
		P_BASE_TABLE     IN VARCHAR2,
		P_PK_COLUMN_1    IN VARCHAR2,
		P_PK_column_2    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_3    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_4    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_5    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_6    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_7    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_8    IN VARCHAR2 DEFAULT NULL,
		P_condition      IN VARCHAR2 DEFAULT NULL)
	RETURN DFF_TABLE PIPELINED;
	
	 FUNCTION get_system_profile_value (p_profile_option_value   IN VARCHAR2,
                                    p_sql_validation         IN   VARCHAR2)
    RETURN varchar2;	
  
     FUNCTION GetValue_cut_country(strData IN VARCHAR2, str_cut IN VARCHAR2) RETURN VARCHAR2;
	   
	   
END XXRES_F11_1_12_KB_TRUNK_pkg;
/

create or replace PACKAGE BODY XXRES_F11_1_12_KB_TRUNK_pkg
AS

	FUNCTION get_rsc_package_version 
    RETURN VARCHAR2
	IS
	BEGIN
		RETURN rsc_package_version;
	END get_rsc_package_version;
---****************************************************************************************************		
FUNCTION get_code_combination(p_code_combination_id number)
RETURN VARCHAR2 DETERMINISTIC
IS
l_concat_value         	  	varchar2(2000) := null;
l_KEY_FLEXFIELD_CODE			varchar2(4);
L_STRUCTURE_INSTANCE_NUMBER		varchar2(18);

begin
	if p_code_combination_id is not null then	
			SELECT STRI.KEY_FLEXFIELD_CODE,
								STRI.STRUCTURE_INSTANCE_NUMBER
			into l_KEY_FLEXFIELD_CODE,l_STRUCTURE_INSTANCE_NUMBER					
								FROM FUSION.FND_KF_STR_INSTANCES_B STRI,
								FUSION.GL_CODE_COMBINATIONS com
								WHERE STRI.APPLICATION_ID          = 101
								AND stri.STRUCTURE_INSTANCE_NUMBER = com.chart_of_accounts_id
								AND COM.CODE_COMBINATION_ID = p_code_combination_id ; 
			
			select	FUSION.fnd_flex_ext.GET_SEGS(APPLICATION_SHORT_NAME   => 'GL',
											KEY_FLEX_CODE   => l_KEY_FLEXFIELD_CODE,
											STRUCTURE_NUMBER    => l_STRUCTURE_INSTANCE_NUMBER,
											COMBINATION_ID      => p_code_combination_id) 
			into l_concat_value						
			from dual; 
	end if;		
        return l_concat_value;
end get_code_combination;
--****************************************************************************************************

---****************************************************************************************************
/*
Get definition value set type Table and concatenate select statement from definition value set type Table.
*/
FUNCTION GET_VALUE_TABLE_TYPE(
		P_VALUE_SET_CODE IN VARCHAR2,
		P_VALUE          IN VARCHAR2)
	RETURN VARCHAR2
IS
	L_RT_VALUE_SET FUSION.FND_FLEX_VS_SETUP_APIS.RT_VALUE_SET;
	L_VALUE VARCHAR2(500);
	l_sql_statement LONG;
BEGIN
	FUSION.FND_FLEX_VS_SETUP_APIS.GET_VALUE_SET(P_VALUE_SET_CODE => P_VALUE_SET_CODE,X_VALUE_SET => L_RT_VALUE_SET) ;
	L_SQL_STATEMENT := 'select '|| L_RT_VALUE_SET.VALUE_COLUMN_NAME||' from '||L_RT_VALUE_SET.FROM_CLAUSE ||' where 1=1'||
	L_RT_VALUE_SET.WHERE_CLAUSE|| ' and  '|| L_RT_VALUE_SET.ID_COLUMN_NAME ||' = '''|| P_VALUE ||'''';

	execute immediate L_SQL_STATEMENT into L_VALUE ;

	RETURN L_VALUE;

END GET_VALUE_TABLE_TYPE;
---****************************************************************************************************

---****************************************************************************************************
/*
Get Descriptive Flexfield value
	P_APPLICATION_ID	Application ID
	P_DFF_CODE			Descriptive Flexfield name
	P_BASE_TABLE		Table name that get value
	P_PK_COLUMN_1		unique column from base table
	P_PK_COLUMN_2		unique column from base table
	P_PK_COLUMN_3		unique column from base table
	P_PK_COLUMN_4		unique column from base table
	P_PK_COLUMN_5		unique column from base table
	P_PK_COLUMN_6		unique column from base table
	P_PK_COLUMN_7		unique column from base table
	P_PK_COLUMN_8		unique column from base table
	P_condition			Condition in where clause from base table
*/
FUNCTION GET_DFF(
		P_APPLICATION_ID IN NUMBER,
		P_DFF_CODE       IN VARCHAR2,
		P_BASE_TABLE     IN VARCHAR2,
		P_PK_COLUMN_1    IN VARCHAR2,
		P_PK_column_2    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_3    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_4    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_5    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_6    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_7    IN VARCHAR2 DEFAULT NULL,
		P_PK_COLUMN_8    IN VARCHAR2 DEFAULT NULL,
		P_condition      IN VARCHAR2 DEFAULT NULL)
	RETURN DFF_TABLE PIPELINED
IS
	L_COLUMN_1           VARCHAR2(30) ;
	l_COLUMN_2           VARCHAR2(30) ;
	L_COLUMN_3           VARCHAR2(30) ;
	L_COLUMN_4           VARCHAR2(30) ;
	L_COLUMN_5           VARCHAR2(30) ;
	L_COLUMN_6           VARCHAR2(30) ;
	L_COLUMN_7           VARCHAR2(30) ;
	l_COLUMN_8           VARCHAR2(30) ;
	V_COLUMN_1           VARCHAR2(250) ;
	v_COLUMN_2           VARCHAR2(250) ;
	v_COLUMN_3           VARCHAR2(250) ;
	v_COLUMN_4           VARCHAR2(250) ;
	v_COLUMN_5           VARCHAR2(250) ;
	v_COLUMN_6           VARCHAR2(250) ;
	V_COLUMN_7           VARCHAR2(250) ;
	V_COLUMN_8           VARCHAR2(250) ;
	V_ATTRIBUTE_CATEGORY VARCHAR2(250) ;
	V_ATTRIBUTE_CATEGORY_NAME VARCHAR2(250) ;
	L_COLUMN_NAME			varchar2(250);
	L_SQL_STATEMENT LONG;
	L_SQL_SELECT_INT LONG;
	L_SQL_SELECT LONG;
	L_SQL_FROM LONG;
	L_SQL_WHERE LONG;
	L_SQL_QUERY LONG;
	L_SQL_query_table LONG;
	L_TABLE_VALUE VARCHAR2(250) ;
	l_PROMPT      VARCHAR2(80) ;
	L_VALUE_SET_ID	number;
TYPE REF_CUR_TYPE
IS
	REF
	CURSOR;
		c_base_table ref_cur_type;
		
		--DFF stucture
		CURSOR C_SEGMENTS(P_context_code VARCHAR2)
		IS
			
			SELECT distinct GLOBALSEGMENT.PROMPT
			,GLOBALSEGMENT.SEGMENT_CODE
			,GLOBALSEGMENT.COLUMN_NAME
			,GLOBALSEGMENT.SEQUENCE_NUMBER
			,VALUESET.VALUE_SET_CODE
			,VALUESET.VALIDATION_TYPE
			,VALUESET.value_data_type
			FROM FUSION.FND_DF_SEGMENTS_VL GlobalSegment
			,FUSION.FND_VS_VALUE_SETS ValueSet
			where GLOBALSEGMENT.VALUE_SET_ID             = VALUESET.VALUE_SET_ID
			AND (GlobalSegment.CONTEXT_CODE               = nvl(P_context_code,'-99999999999999') or GlobalSegment.CONTEXT_CODE ='Global Data Elements')
			AND GLOBALSEGMENT.APPLICATION_ID             = P_APPLICATION_ID
			AND GLOBALSEGMENT.DESCRIPTIVE_FLEXFIELD_CODE = P_DFF_CODE
			ORDER BY SEQUENCE_NUMBER ;
		
		rec DFF_RECORD;
	BEGIN
		L_COLUMN_1      := P_PK_COLUMN_1;
		L_COLUMN_2      := NVL(P_PK_COLUMN_2,'''Col_2''') ;
		L_COLUMN_3      := NVL(P_PK_COLUMN_3,'''Col_3''') ;
		L_COLUMN_4      := NVL(P_PK_COLUMN_4,'''Col_4''') ;
		L_COLUMN_5      := NVL(P_PK_COLUMN_5,'''Col_5''') ;
		L_COLUMN_6      := NVL(P_PK_COLUMN_6,'''Col_6''') ;
		L_COLUMN_7      := NVL(P_PK_COLUMN_7,'''Col_7''') ;
		L_COLUMN_8      := NVL(P_PK_COLUMN_8,'''Col_8''') ;
		L_SQL_STATEMENT := 'select '||L_COLUMN_1||','||L_COLUMN_2||','||L_COLUMN_3||','||L_COLUMN_4||','||L_COLUMN_5||',' ||
		L_COLUMN_6||','||L_COLUMN_7||','||L_COLUMN_8||',Attribute_category from '||P_BASE_TABLE|| ' where '|| nvl(P_condition,'1=1') ;
		
	
		--1. select data (parameter P_PK_COLUMN_1 - 8) and Attribute_category from base table where condition on P_condition parameter
		OPEN C_BASE_TABLE FOR l_sql_statement ;
		LOOP
			
			FETCH C_BASE_TABLE
			INTO V_COLUMN_1
			,V_COLUMN_2
			,V_COLUMN_3
			,V_COLUMN_4
			,V_COLUMN_5
			,V_COLUMN_6
			,V_COLUMN_7
			,V_COLUMN_8
			,V_ATTRIBUTE_CATEGORY ;
			EXIT
		WHEN C_BASE_TABLE%NOTFOUND;
			L_SQL_SELECT_INT := 'select '||L_COLUMN_1||','||L_COLUMN_2||','||L_COLUMN_3||','||L_COLUMN_4||','||L_COLUMN_5||','
			|| L_COLUMN_6||','||L_COLUMN_7||','||L_COLUMN_8 ;
			L_SQL_FROM := '  from FUSION.'|| P_BASE_TABLE ||' where '|| nvl(P_condition,'1=1') ||' and ' ||L_COLUMN_1||' = '|| TO_CHAR(''''||V_COLUMN_1||'''') ;
			
			IF P_PK_COLUMN_2 is not NULL THEN
				L_SQL_where     := ' and ' || l_COLUMN_2 ||' = '|| TO_CHAR(''''||V_COLUMN_2||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_3 is not  NULL THEN
				L_SQL_where     := L_SQL_where ||' and ' ||  l_COLUMN_3 ||' = '|| TO_CHAR(''''||V_COLUMN_3||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_4 is not  NULL THEN
				L_SQL_where     := L_SQL_where ||' and ' || l_COLUMN_4 ||' = '|| TO_CHAR(''''||V_COLUMN_4||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_5 is not  NULL THEN
				L_SQL_where     := L_SQL_where ||' and ' || l_COLUMN_5 ||' = '|| TO_CHAR(''''||V_COLUMN_5||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_6 is not  NULL THEN
				L_SQL_where     := L_SQL_where ||' and ' || l_COLUMN_6 ||' = '|| TO_CHAR(''''||V_COLUMN_6||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_7 is not  NULL THEN
				L_SQL_where     := L_SQL_where || l_COLUMN_7 ||' = '|| TO_CHAR(''''||V_COLUMN_7||'''') ;
			
			END IF;
			
			IF P_PK_COLUMN_8 is not  NULL THEN
				L_SQL_WHERE     := L_SQL_WHERE || l_COLUMN_8 ||' = '|| TO_CHAR(''''||V_COLUMN_8||'''') ;
			
			END IF;
			
			--Check context segments Will add first row for context segment name
			IF V_Attribute_category IS NOT NULL THEN
				
				SELECT GLOBALSEGMENT.PROMPT,GLOBALSEGMENT.VALUE_SET_ID
				INTO l_PROMPT,L_VALUE_SET_ID
				FROM FUSION.FND_DF_SEGMENTS_VL GLOBALSEGMENT
				WHERE GLOBALSEGMENT.APPLICATION_ID           = P_APPLICATION_ID
				AND GLOBALSEGMENT.DESCRIPTIVE_FLEXFIELD_CODE = P_DFF_CODE
				AND GLOBALSEGMENT.COLUMN_NAME                = 'ATTRIBUTE_CATEGORY';
				
				if L_VALUE_SET_ID is null then
					select T.name 
					into V_ATTRIBUTE_CATEGORY_Name
					FROM FUSION.FND_DF_CONTEXTS_B B
					, FUSION.FND_DF_CONTEXTS_TL T
					WHERE B.APPLICATION_ID           = T.APPLICATION_ID
					AND B.DESCRIPTIVE_FLEXFIELD_CODE = T.DESCRIPTIVE_FLEXFIELD_CODE
					AND B.CONTEXT_CODE               = T.CONTEXT_CODE
					AND T.LANGUAGE                   = USERENV('LANG') 
					and T.APPLICATION_ID           	 = P_APPLICATION_ID
					and T.DESCRIPTIVE_FLEXFIELD_CODE = P_DFF_CODE
					and T.CONTEXT_CODE 				 = V_Attribute_category;
				end if;
				
				L_SQL_SELECT := L_SQL_SELECT_INT || ' ,'''||l_PROMPT||''','''||nvl(V_ATTRIBUTE_CATEGORY_Name,V_Attribute_category)||''','||'''00''' ;
				L_SQL_QUERY  := L_SQL_SELECT||L_SQL_FROM||L_SQL_WHERE;
				EXECUTE immediate L_SQL_QUERY INTO REC ;
				PIPE row(REC) ;
				
			END IF;
				
				--2. Get DFF stucture (Sequence ,prompt,table column name,type) and loop append sql statement from  step 1
				FOR I IN C_SEGMENTS(V_ATTRIBUTE_CATEGORY)
				LOOP
					
					
					IF I.VALUE_DATA_TYPE = 'VARCHAR2' THEN
						L_COLUMN_NAME	:=	I.COLUMN_NAME ;
					ELSIF I.VALUE_DATA_TYPE = 'NUMBER' THEN
						L_COLUMN_NAME	:=	'TO_CHAR('||I.COLUMN_NAME||')';
					ELSIF I.VALUE_DATA_TYPE IN ('DATE','TIMESTAMP') THEN
						L_COLUMN_NAME	:=	'TO_CHAR('||I.COLUMN_NAME||',''DD-Mon-YYYY'')';				
					end if;
					
					L_SQL_SELECT	:=	null;	
					
					
					--4. Value set validate type (Format Only,Independent,Dependent,Subset) get value directly
					IF I.VALIDATION_TYPE != 'TABLE' THEN
						L_SQL_SELECT        := L_SQL_SELECT_INT || ' ,'''||I.PROMPT||''','||L_COLUMN_NAME||','||i.SEQUENCE_NUMBER ;
					
					ELSE
					--5. Value set validate type table and get value from table type definition
						L_SQL_QUERY_TABLE := 'select ' ||I.COLUMN_NAME || L_SQL_FROM || L_SQL_WHERE;
						execute immediate L_SQL_QUERY_TABLE into L_TABLE_VALUE ;
						
						if L_TABLE_VALUE is not null then
						
							L_SQL_SELECT    := L_SQL_SELECT_INT || ' ,'''||I.PROMPT||''','''||GET_VALUE_TABLE_TYPE(I.VALUE_SET_CODE,
							l_table_value) ||''','||I.SEQUENCE_NUMBER ;
						
						END IF;
					
					END IF;
					
					--Excute sql
					IF L_SQL_SELECT IS NOT NULL THEN
						L_SQL_QUERY    := L_SQL_SELECT||L_SQL_FROM||L_SQL_WHERE;
						EXECUTE IMMEDIATE L_SQL_QUERY INTO REC ;
						PIPE row(REC) ;
					
					END IF;
				
				END LOOP;		
			
		
		END LOOP;
		CLOSE C_BASE_TABLE;	
		
		RETURN;
	
	END GET_DFF;
	
	 FUNCTION get_system_profile_value (p_profile_option_value   IN VARCHAR2,
                                      p_sql_validation           IN  VARCHAR2)
      RETURN varchar2
   IS
      
	  v_select						   VARCHAR2(6) := 'SELECT';	
	  v_from						   VARCHAR2(4) := 'FROM';
	  v_where						   VARCHAR2(5) := 'WHERE';
	  v_order_by					   VARCHAR2(8) := 'ORDER BY';
	  v_comma					   	   VARCHAR2(1) := ',';
	  V_double_codes				   VARCHAR2(1) := '"';	
	  
	  
	  v_sql_validation                 VARCHAR2 (2000);
      v_profile_value                  VARCHAR2 (240);
	  v_select_position 			   number;	
	  v_from_position 			   	   number;	
	  v_where_position 			       number;	
	  v_order_by_position 			   number;	
	  v_end_position 			   	   number;	
	  v_comma_position 			   	   number;
      v_comma_position2	  			   number;	
	  v_double_codes_position		   number;	
	  
	  v_meaning						   VARCHAR2 (250);	
	  v_value						   VARCHAR2 (250);
      v_from_statement			  	   VARCHAR2 (2000);
	  v_where_statement			  	   VARCHAR2 (2000);
	  
      v_sql_statement                  VARCHAR2 (2000);      
      v_result                         VARCHAR2 (2000);
	  
	 
   BEGIN
      BEGIN
	  
		if p_sql_validation is null then
			return p_profile_option_value;
		end if;
	  
        v_sql_validation := p_sql_validation; 
        v_profile_value := ''''||p_profile_option_value||'''';
		 
		v_select_position 		:=	INSTR(upper(v_sql_validation),v_select,1);	
	    v_from_position 		:=	INSTR(upper(v_sql_validation),v_from,1);		
	    v_where_position 		:=	INSTR(upper(v_sql_validation),v_where,1);
	    v_order_by_position 	:=	INSTR(upper(v_sql_validation),v_order_by,1);
		v_end_position			:=	length(v_sql_validation);
		v_comma_position		:=	INSTR(v_sql_validation,v_comma,1);
		v_comma_position2		:=	INSTR(v_sql_validation,v_comma,1,2);

		--Get meaning column
		v_meaning				:=	substr(v_sql_validation,v_select_position+6,v_comma_position-(v_select_position+6)); 
		
		--Get value column
		if v_comma_position2 = 0 or (v_comma_position2 > v_from_position) then
			v_value					:=	substr(v_sql_validation,v_comma_position+1,v_from_position-(v_comma_position+1)); 
		else
			v_value					:=	substr(v_sql_validation,v_comma_position+1,v_comma_position2-(v_comma_position+1)); 
			--v_value					:=	substr(v_sql_validation,v_comma_position+1,v_from_position-(v_comma_position2+1)); 
		
			--Check  double codes
			v_double_codes_position	:=	INSTR(v_value,v_double_codes,1);
			
			if v_double_codes_position <> 0 then
				v_value				:= 	substr(v_value,1,v_double_codes_position-1);			
			end if;
			
		end if;	
		
		
		--Get from and where statment
		if v_where_position = 0 then
			if v_order_by_position = 0 then
				v_from_statement		:=	substr(v_sql_validation,v_from_position,(v_end_position+1)-v_from_position);
			else
				v_from_statement		:=	substr(v_sql_validation,v_from_position,v_order_by_position-v_from_position);
			end if;	
		else
		
			v_from_statement		:=	substr(v_sql_validation,v_from_position,v_where_position-v_from_position); 
			
			if v_order_by_position = 0 then				
				v_where_statement		:=	substr(v_sql_validation,v_where_position,(v_end_position+1)-v_where_position); 
			else				
				v_where_statement		:=	substr(v_sql_validation,v_where_position,v_order_by_position-v_where_position); 
			end if;	
		end if;	

		/*
			DBMS_OUTPUT.PUT_LINE('v_select_position : '||V_SELECT_POSITION);
			dbms_output.put_line('v_comma_position : '||v_comma_position);
			dbms_output.put_line('v_comma_position2 : '||v_comma_position2);
			dbms_output.put_line('v_meaning : '||v_meaning);
			dbms_output.put_line('v_value : '||v_value);
			dbms_output.put_line('v_from_statement : '||v_from_statement);
			DBMS_OUTPUT.PUT_LINE('v_where_statement : '||V_WHERE_STATEMENT);
			DBMS_OUTPUT.PUT_LINE('v_from_position : '||v_from_position);
			DBMS_OUTPUT.PUT_LINE('v_where_position : '||V_WHERE_POSITION);
			dbms_output.put_line('v_order_by_position : '||v_order_by_position);
			*/
			
			--concatenate statement
			v_sql_statement	:=	v_select ||' '|| v_meaning ||' '|| v_from_statement
								||' '||	 nvl(v_where_statement,v_where ||' 1 = 1 ')
								||' and '|| v_value ||'='||v_profile_value;
			
			EXECUTE IMMEDIATE v_sql_statement into  v_result;
			return v_result;       

        end;
		
		EXCEPTION      
			WHEN OTHERS THEN  
		return null;

   END get_system_profile_value;
   
   FUNCTION GetValue_cut_country(strData VARCHAR2, str_cut VARCHAR2) RETURN VARCHAR2 IS
   
  v_max 		     NUMBER;
  v_pos              NUMBER;
  v_last_comma 		 varchar2(50) := null;
  --strData  varchar2(1500) :=  'CARRETERA MIGUEL ALEMAN, KM. 14.5 INT 3C, BUSINESS PARK MONTERREY,XXXXX,66633  APODACA, NUEVO LEON,MEXICO';
 
  
	  FUNCTION CountDelimeter(strData VARCHAR2, strDelimeter VARCHAR2) RETURN NUMBER IS
	  BEGIN
		v_pos := 1;
		WHILE instr(strData, strDelimeter, 1, v_pos) <> 0
		LOOP 
			   v_pos := v_pos + 1;
			   
		END LOOP;
		RETURN (v_pos - 1);
	  END CountDelimeter;  
  
	BEGIN /**** main ******/

	  if strData is null then
		RETURN null;
	  end if;
	  v_max := CountDelimeter(strData, ',');
	  
	  
	  IF v_max = 0 THEN
			RETURN strData; 
	  ELSE
	 
	       v_last_comma := (substr(strData, instr(strData, ',', 1, v_max) + 1, length(strData) - instr(strData, ',', 1, v_max) ) ); /*cut word after last comma','  */
	 
		  if( str_cut = 'MEXICO' and trim(upper(v_last_comma)) = 'MEXICO' ) THEN 
			RETURN (substr(strData, 1, length(strData) - (length(strData) - instr(strData, ',', 1, v_max)) - 1 )); /* cut first until before last comma ',' */
		  end if;
		  
	  END IF;
	  
	END GetValue_cut_country ;

END XXRES_F11_1_12_KB_TRUNK_pkg;
/